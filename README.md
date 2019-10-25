# terraform-module-aws-eks-worker-pool

Terraform module that allows you to create EKS worker pools.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_cidr\_blocks | List of CIDR blocks that will be allowed to communicate on high ports with the worker pool. | list | `[]` | no |
| allowed\_security\_goup\_ids | List of security group ID's that are allowed to communicate on high ports with the worker pool. | list | `[]` | no |
| ami\_name | Name of the ami that will be used for eks worker nodes. NOTE: If ami is set, this will be ignored. | string | `"amazon-eks-node-1.13*"` | no |
| associate\_public\_ip\_address | Whether or not to associate public IP's to the worker pool nodes. | string | `"false"` | no |
| autoscaling\_group\_desired\_capacity | Desired number of nodes in the worker pool. NOTE: Do not specify it if you plan to do autoscaling. | number | `"null"` | no |
| autoscaling\_group\_max\_size | Maximum number of nodes in the worker pool. | string | `"10"` | no |
| autoscaling\_group\_min\_size | Minimum number of nodes in the worker pool. | string | `"2"` | no |
| autoscaling\_group\_name | Name of the autoscaling group of the worker pool. | string | `"eks-worker-pool"` | no |
| autoscaling\_group\_tags | List of map of tags of the autoscaling group of the worker pool. NOTE: map format [ { key = STRING, value = STRING, propagate_at_launch = BOOL } ]. | list | `[]` | no |
| cluster\_certificate | Base 64 encoded string of the certificate of the EKS cluster to be joined by the worker pool nodes. | string | n/a | yes |
| cluster\_endpoint | Endpoint of the EKS cluster to be joined by the worker pool nodes. | string | n/a | yes |
| cluster\_name | Name of the EKS cluster to be joined by the worker pool nodes. | string | n/a | yes |
| cluster\_security\_group\_id | ID of the security group of the EKS cluster. | string | n/a | yes |
| enabled | Whther or not to enable this worker pool. | string | `"true"` | no |
| iam\_instance\_profile\_name | Name of the instance profile that will be attached to the worker pool nodes. | string | `"eks-worker-pool"` | no |
| iam\_role\_name | Name of the IAM role that will be assigned on the worker pool nodes. | string | `"eks-worker-pool"` | no |
| iam\_role\_policy\_attachment\_arns | List of additionnal policy arns that will be attached to the role of the worker pool nodes. | list | `[]` | no |
| iam\_role\_tags | Map of tags that will be added on the IAM role. | map | `{}` | no |
| image\_id | ID of the AMI that will be used for the worker nodes. NOTE: Leave empty to use `ami_name` variable. | string | `""` | no |
| instance\_type | Type of instance that will be used for the worker pool nodes. | string | `"t3.small"` | no |
| name\_prefix | Name prefix to use for the launch configuration of the worker pool. | string | `"eks-worker-pool"` | no |
| security\_group\_ids | List of additionnal security group ids that will be attached to the worker pool nodes. | list | `[]` | no |
| security\_group\_name | Name of the security group for the worker pool nodes. | string | `"eks-worker-pool"` | no |
| security\_group\_tags | Map of tags that will be applied on the security group for the worker pool nodes. | map | `{}` | no |
| subnet\_ids | List of subnet ID's that will be used to deploy the EKS worker pool. | list | n/a | yes |
| tags | Map of tags that will be added on all resources. | map | `{}` | no |
| use\_max\_pods | Maximum number of pods that will be allowed to be scheduled on each node. | string | `"110"` | no |

## Outputs

| Name | Description |
|------|-------------|
| autoscaling\_group\_arn | ARN of the autoscaling group that is created. |
| autoscaling\_group\_id | ID of the autoscaling group that is created. |
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
| security\_group\_arn | ARN of the security group that is created. |
| security\_group\_id | ID of the security group that is created. |
| security\_group\_name | Name of the security group that is created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
