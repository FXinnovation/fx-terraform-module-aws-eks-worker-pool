# terraform-module-aws-eks-worker-pool

Terraform module that allows you to create EKS worker pools.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 2.27 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.27 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_bootstrap\_arguments | Additionnal arguments to pass to the EKS bootstrap script (from AWS). | `string` | `""` | no |
| allowed\_cidr\_blocks | List of CIDR blocks that will be allowed to communicate on high ports with the worker pool. | `list` | `[]` | no |
| allowed\_security\_group\_ids | List of security group ID's that are allowed to communicate on high ports with the worker pool. | `list` | `[]` | no |
| associate\_public\_ip\_address | Whether or not to associate public IP's to the worker pool nodes. | `bool` | `false` | no |
| autoscaling\_group\_desired\_capacity | Desired number of nodes in the worker pool. NOTE: Do not specify it if you plan to do autoscaling. | `number` | `null` | no |
| autoscaling\_group\_enabled\_metrics | A list of metrics to collect. The allowed values are GroupDesiredCapacity, GroupInServiceCapacity, GroupPendingCapacity, GroupMinSize, GroupMaxSize, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupStandbyCapacity, GroupTerminatingCapacity, GroupTerminatingInstances, GroupTotalCapacity, GroupTotalInstances. | `list(string)` | `[]` | no |
| autoscaling\_group\_max\_size | Maximum number of nodes in the worker pool. | `number` | `10` | no |
| autoscaling\_group\_min\_size | Minimum number of nodes in the worker pool. | `number` | `2` | no |
| autoscaling\_group\_name | Name of the autoscaling group of the worker pool. | `string` | `"eks-worker-pool"` | no |
| autoscaling\_group\_tags | List of map of tags of the autoscaling group of the worker pool. NOTE: map format [ { key = STRING, value = STRING, propagate\_at\_launch = BOOL } ]. | `list` | `[]` | no |
| cluster\_name | Name of the EKS cluster to be joined by the worker pool nodes. | `string` | n/a | yes |
| cluster\_security\_group\_id | ID of the security group of the EKS cluster. | `string` | n/a | yes |
| customized\_commands | List of shell commands to execute before joining eks cluster | `string` | `""` | no |
| enabled | Whther or not to enable this worker pool. | `bool` | `true` | no |
| iam\_instance\_profile\_name | Name of the instance profile that will be attached to the worker pool nodes. | `string` | `"eks-worker-pool"` | no |
| iam\_role\_name | Name of the IAM role that will be assigned on the worker pool nodes. | `string` | `"eks-worker-pool"` | no |
| iam\_role\_policy\_attachment\_arns | List of additionnal policy arns that will be attached to the role of the worker pool nodes. | `list` | `[]` | no |
| iam\_role\_tags | Map of tags that will be added on the IAM role. | `map` | `{}` | no |
| image\_id | ID of the AMI that will be used for the worker nodes. NOTE: Leave empty to use `ami_name` variable. | `string` | `""` | no |
| instance\_type | Type of instance that will be used for the worker pool nodes. | `string` | `"t3.small"` | no |
| key\_name | Name of the AWS Key pair to attach to the instances. | `string` | `null` | no |
| kubernetes\_version | Version of the EKS cluster. Will be used to determine which AMI to use for eks worker nodes. NOTE: If ami is set, this will be ignored. | `string` | n/a | yes |
| name\_prefix | Name prefix to use for the launch configuration of the worker pool. | `string` | `"eks-worker-pool"` | no |
| security\_group\_ids | List of security group ids that will be attached to the worker pool nodes. | `list` | `[]` | no |
| security\_group\_name | Name of the security group for the worker pool nodes. | `string` | `"eks-worker-pool"` | no |
| security\_group\_tags | Map of tags that will be applied on the security group for the worker pool nodes. | `map` | `{}` | no |
| spot\_price | The maximum price to use for reserving spot instances. | `string` | `null` | no |
| subnet\_ids | List of subnet ID's that will be used to deploy the EKS worker pool. | `list` | n/a | yes |
| tags | Map of tags that will be added on all resources. | `map` | `{}` | no |
| use\_max\_pods | Maximum number of pods that will be allowed to be scheduled on each node. | `bool` | `false` | no |
| volume\_size | Root block device volume size. | `number` | `50` | no |
| volume\_type | Root block device volume type. | `string` | `"standard"` | no |
| worker\_pool\_security\_group\_ids | List of security group ids of the other worker pools available on the cluster. | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| autoscaling\_group\_arn | ARN of the autoscaling group that is created. |
| autoscaling\_group\_id | ID of the autoscaling group that is created. |
| aws\_auth\_data | List of maps representing the needed config to add to the aws-auth configmap on EKS. |
| iam\_instance\_profile\_arn | ARN of the IAM instance profile that is created. |
| iam\_instance\_profile\_id | ID of the IAM instance profile that is created. |
| iam\_instance\_profile\_name | Name of the IAM instance profile that is created. |
| iam\_instance\_profile\_unique\_id | Uniauq ID of the IAM instance profile that is created. |
| iam\_role\_arn | ARN of the IAM role that is created. |
| iam\_role\_id | ID of the IAM role that is created. |
| iam\_role\_name | Name of the IAM role that is created. |
| iam\_role\_unique\_id | Uniauq ID of the IAM role that is created. |
| launch\_configuration\_id | ID of the launch configruation that is created. |
| launch\_configuration\_name | Name of the launch configruation that is created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
