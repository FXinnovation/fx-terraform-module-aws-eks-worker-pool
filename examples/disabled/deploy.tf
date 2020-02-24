provider "aws" {
  version    = "~> 2.27.0"
  region     = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "random" {
  version = "~> 2.0"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_groups" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "group-name"
    values = ["default"]
  }

}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.default.id
}

resource "random_string" "this" {
  length  = 8
  special = false
  upper   = false
  number  = false
}

module "eks_worker_pool" {
  source = "../../"

  enabled = false

  autoscaling_group_name = random_string.this.result

  # NOTE: These values will not make a functionning cluster. These should be
  # replaced by actual values when used in an actual deployment. But they are
  # sufficient for the purpos of this example.
  cluster_name              = random_string.this.result
  cluster_security_group_id = data.aws_security_groups.this.ids[0]

  iam_role_name             = random_string.this.result
  iam_instance_profile_name = random_string.this.result

  kubernetes_version = "1.13"

  name_prefix = random_string.this.result

  security_group_name = random_string.this.result

  subnet_ids = tolist(data.aws_subnet_ids.this.ids)
}
