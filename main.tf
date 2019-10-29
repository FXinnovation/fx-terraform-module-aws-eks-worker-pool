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
  tags = {
    "Terraform" = "true"
  }
  vpc_id                     = data.aws_subnet.this.vpc_id
  allowed_security_group_ids = concat([var.cluster_security_group_id], var.allowed_security_group_ids)
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
  name_prefix                 = var.name_prefix
  security_groups             = concat(aws_security_group.this.*.id, var.security_group_ids)
  user_data_base64 = base64encode(
    templatefile(
      "${path.module}/templates/userdata.tpl",
      {
        cluster_name        = var.cluster_name,
        cluster_endpoint    = var.cluster_endpoint,
        cluster_certificate = var.cluster_certificate,
        use_max_pods        = var.use_max_pods
      }
    )
  )

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
}

#####
# Security Group
#####

resource "aws_security_group" "this" {
  count = var.enabled ? 1 : 0

  name        = var.security_group_name
  description = "Security group for EKS workers."
  vpc_id      = local.vpc_id

  tags = merge(
    local.tags,
    var.tags,
    var.security_group_tags
  )
}

resource "aws_security_group_rule" "this_ingress_sg_443" {
  count = var.enabled ? length(local.allowed_security_group_ids) : 0

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = element(concat(aws_security_group.this.*.id, list("")), 0)
  source_security_group_id = local.allowed_security_group_ids[count.index]
}

resource "aws_security_group_rule" "client_egress_sg_443" {
  count = var.enabled ? length(local.allowed_security_group_ids) : 0

  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = element(concat(aws_security_group.this.*.id, list("")), 0)
  security_group_id        = local.allowed_security_group_ids[count.index]
}

resource "aws_security_group_rule" "this_ingress_sg_1025_65535" {
  count = var.enabled ? length(local.allowed_security_group_ids) : 0

  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = element(concat(aws_security_group.this.*.id, list("")), 0)
  source_security_group_id = local.allowed_security_group_ids[count.index]
}

resource "aws_security_group_rule" "client_egress_sg_1025_65535" {
  count = var.enabled ? length(local.allowed_security_group_ids) : 0

  type                     = "egress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = element(concat(aws_security_group.this.*.id, list("")), 0)
  security_group_id        = local.allowed_security_group_ids[count.index]
}

resource "aws_security_group_rule" "this_ingress_cidrs_1025_65535" {
  count = var.enabled && length(var.allowed_cidr_blocks) > 0 ? 1 : 0

  type              = "ingress"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = element(concat(aws_security_group.this.*.id, list("")), 0)
  cidr_blocks       = var.allowed_cidr_blocks
}

resource "aws_security_group_rule" "this_ingress_self_any" {
  count = var.enabled ? 1 : 0

  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = element(concat(aws_security_group.this.*.id, list("")), 0)
}

# NOTE: This might not be usefull or necessary but is what is usually done.
resource "aws_security_group_rule" "this_egress_any" {
  count = var.enabled ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = element(concat(aws_security_group.this.*.id, list("")), 0)
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
