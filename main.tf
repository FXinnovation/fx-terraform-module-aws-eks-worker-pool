#####
# Datasource
#####

data "aws_subnet" "this" {
  id = var.subnet_ids[0]
}

data "aws_ami" "this" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.kubernetes_version}*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}


#####
# Locals
#####

locals {
  vpc_id                     = data.aws_subnet.this.vpc_id
  allowed_security_group_ids = concat([var.cluster_security_group_id], var.allowed_security_group_ids)

  aws_auth_data = [
    {
      rolearn  = element(concat(aws_iam_role.this.*.arn, list("")), 0)
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes"
      ]
    }
  ]

  tags = {
    "Terraform" = "true"
  }
}


#####
# ASG
#####

resource "aws_launch_configuration" "this" {
  count = var.enabled ? 1 : 0

  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = element(concat(aws_iam_instance_profile.this.*.name, list("")), 0)
  image_id                    = var.image_id == "" ? data.aws_ami.this.id : var.image_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  name_prefix                 = var.name_prefix
  security_groups             = var.security_group_ids
  spot_price                  = var.spot_price

  user_data_base64 = base64encode(
    templatefile(
      "${path.module}/templates/userdata.tpl",
      {
        cluster_name        = var.cluster_name,
        use_max_pods        = var.use_max_pods,
        customized_commands = var.customized_commands
        bootstrap_arguments = var.additional_bootstrap_arguments
      }
    )
  )

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  count = var.enabled ? 1 : 0

  desired_capacity     = var.autoscaling_group_desired_capacity
  launch_configuration = element(concat(aws_launch_configuration.this.*.id, list("")), 0)
  max_size             = var.autoscaling_group_max_size
  min_size             = var.autoscaling_group_min_size
  name                 = var.autoscaling_group_name
  vpc_zone_identifier  = var.subnet_ids
  enabled_metrics      = var.autoscaling_group_enabled_metrics

  tag {
    key                 = "Name"
    value               = var.autoscaling_group_name
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "True"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.autoscaling_group_tags
    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = tag.value.propagate_at_launch
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.this_node_policy,
    aws_iam_role_policy_attachment.this_cni_policy,
    aws_iam_role_policy_attachment.this_container_registry,
    aws_iam_role_policy_attachment.this
  ]
}

#####
# IAM
#####

resource "aws_iam_role" "this" {
  count = var.enabled ? 1 : 0

  name               = var.iam_role_name
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  tags = merge(
    local.tags,
    var.tags,
    var.iam_role_tags
  )
}

resource "aws_iam_role_policy_attachment" "this_node_policy" {
  count = var.enabled ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = element(concat(aws_iam_role.this.*.name, list("")), 0)
}

resource "aws_iam_role_policy_attachment" "this_cni_policy" {
  count = var.enabled ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = element(concat(aws_iam_role.this.*.name, list("")), 0)
}

resource "aws_iam_role_policy_attachment" "this_container_registry" {
  count = var.enabled ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = element(concat(aws_iam_role.this.*.name, list("")), 0)
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.iam_role_policy_attachment_arns)

  policy_arn = each.key
  role       = element(concat(aws_iam_role.this.*.name, list("")), 0)
}

resource "aws_iam_instance_profile" "this" {
  count = var.enabled ? 1 : 0

  name = var.iam_instance_profile_name
  role = element(concat(aws_iam_role.this.*.name, list("")), 0)
}
