variable "additional_bootstrap_arguments" {
  description = "Additionnal arguments to pass to the EKS bootstrap script (from AWS)."
  default     = ""
}

variable "allowed_security_group_ids" {
  description = "List of security group ID's that are allowed to communicate on high ports with the worker pool."
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks that will be allowed to communicate on high ports with the worker pool."
  default     = []
}

variable "autoscaling_group_desired_capacity" {
  description = "Desired number of nodes in the worker pool. NOTE: Do not specify it if you plan to do autoscaling."
  default     = null
  type        = number
}

variable "autoscaling_group_max_size" {
  description = "Maximum number of nodes in the worker pool."
  default     = 10
}

variable "autoscaling_group_min_size" {
  description = "Minimum number of nodes in the worker pool."
  default     = 2
}

variable "autoscaling_group_name" {
  description = "Name of the autoscaling group of the worker pool."
  default     = "eks-worker-pool"
}

variable "autoscaling_group_tags" {
  description = "List of map of tags of the autoscaling group of the worker pool. NOTE: map format [ { key = STRING, value = STRING, propagate_at_launch = BOOL } ]."
  default     = []
}

variable "kubernetes_version" {
  description = "Version of the EKS cluster. Will be used to determine which AMI to use for eks worker nodes. NOTE: If ami is set, this will be ignored."
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether or not to associate public IP's to the worker pool nodes."
  default     = false
}

variable "cluster_name" {
  description = "Name of the EKS cluster to be joined by the worker pool nodes."
  type        = string
}

variable "cluster_security_group_id" {
  description = "ID of the security group of the EKS cluster."
  type        = string
}

variable "enabled" {
  description = "Whther or not to enable this worker pool."
  default     = true
}

variable "iam_role_name" {
  description = "Name of the IAM role that will be assigned on the worker pool nodes."
  default     = "eks-worker-pool"
}

variable "iam_role_tags" {
  description = "Map of tags that will be added on the IAM role."
  default     = {}
}

variable "iam_role_policy_attachment_arns" {
  description = "List of additionnal policy arns that will be attached to the role of the worker pool nodes."
  default     = []
}

variable "iam_instance_profile_name" {
  description = "Name of the instance profile that will be attached to the worker pool nodes."
  default     = "eks-worker-pool"
}

variable "image_id" {
  description = "ID of the AMI that will be used for the worker nodes. NOTE: Leave empty to use `ami_name` variable."
  default     = ""
}

variable "instance_type" {
  description = "Type of instance that will be used for the worker pool nodes."
  default     = "t3.small"
}

variable "key_name" {
  description = "Name of the AWS Key pair to attach to the instances."
  default     = null
  type        = string
}

variable "name_prefix" {
  description = "Name prefix to use for the launch configuration of the worker pool."
  default     = "eks-worker-pool"
}

variable "security_group_ids" {
  description = "List of additionnal security group ids that will be attached to the worker pool nodes."
  default     = []
}

variable "security_group_name" {
  description = "Name of the security group for the worker pool nodes."
  default     = "eks-worker-pool"
}

variable "security_group_tags" {
  description = "Map of tags that will be applied on the security group for the worker pool nodes."
  default     = {}
}

variable "spot_price" {
  description = "The maximum price to use for reserving spot instances."
  default     = null
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet ID's that will be used to deploy the EKS worker pool."
  type        = list
}

variable "tags" {
  description = "Map of tags that will be added on all resources."
  default     = {}
}

variable "use_max_pods" {
  description = "Maximum number of pods that will be allowed to be scheduled on each node."
  default     = false
}

variable "customized_commands" {
  description = "List of shell commands to execute before joining eks cluster"
  default     = ""
}

variable "volume_type" {
  description = "Root block device volume type."
  default     = "standard"
}

variable "volume_size" {
  description = "Root block device volume size."
  default     = 50
}

variable "worker_pool_security_group_ids" {
  description = "List of security group ids of the other worker pools available on the cluster."
  default     = []
}
