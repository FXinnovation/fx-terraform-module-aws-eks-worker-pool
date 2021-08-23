# terraform-module-aws-eks-worker-pool

Terraform module that allows you to create EKS worker pools.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this_cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this_container_registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_bootstrap_arguments"></a> [additional\_bootstrap\_arguments](#input\_additional\_bootstrap\_arguments) | Additionnal arguments to pass to the EKS bootstrap script (from AWS). | `string` | `""` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks that will be allowed to communicate on high ports with the worker pool. | `list` | `[]` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | List of security group ID's that are allowed to communicate on high ports with the worker pool. | `list` | `[]` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether or not to associate public IP's to the worker pool nodes. | `bool` | `false` | no |
| <a name="input_autoscaling_group_desired_capacity"></a> [autoscaling\_group\_desired\_capacity](#input\_autoscaling\_group\_desired\_capacity) | Desired number of nodes in the worker pool. NOTE: Do not specify it if you plan to do autoscaling. | `number` | `null` | no |
| <a name="input_autoscaling_group_enabled_metrics"></a> [autoscaling\_group\_enabled\_metrics](#input\_autoscaling\_group\_enabled\_metrics) | A list of metrics to collect. The allowed values are GroupDesiredCapacity, GroupInServiceCapacity, GroupPendingCapacity, GroupMinSize, GroupMaxSize, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupStandbyCapacity, GroupTerminatingCapacity, GroupTerminatingInstances, GroupTotalCapacity, GroupTotalInstances. | `list(string)` | `[]` | no |
| <a name="input_autoscaling_group_max_size"></a> [autoscaling\_group\_max\_size](#input\_autoscaling\_group\_max\_size) | Maximum number of nodes in the worker pool. | `number` | `10` | no |
| <a name="input_autoscaling_group_min_size"></a> [autoscaling\_group\_min\_size](#input\_autoscaling\_group\_min\_size) | Minimum number of nodes in the worker pool. | `number` | `2` | no |
| <a name="input_autoscaling_group_name"></a> [autoscaling\_group\_name](#input\_autoscaling\_group\_name) | Name of the autoscaling group of the worker pool. | `string` | `"eks-worker-pool"` | no |
| <a name="input_autoscaling_group_tags"></a> [autoscaling\_group\_tags](#input\_autoscaling\_group\_tags) | List of map of tags of the autoscaling group of the worker pool. NOTE: map format [ { key = STRING, value = STRING, propagate\_at\_launch = BOOL } ]. | `list` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster to be joined by the worker pool nodes. | `string` | n/a | yes |
| <a name="input_cluster_security_group_id"></a> [cluster\_security\_group\_id](#input\_cluster\_security\_group\_id) | ID of the security group of the EKS cluster. | `string` | n/a | yes |
| <a name="input_customized_commands"></a> [customized\_commands](#input\_customized\_commands) | List of shell commands to execute before joining eks cluster | `string` | `""` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whther or not to enable this worker pool. | `bool` | `true` | no |
| <a name="input_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#input\_iam\_instance\_profile\_name) | Name of the instance profile that will be attached to the worker pool nodes. | `string` | `"eks-worker-pool"` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name of the IAM role that will be assigned on the worker pool nodes. | `string` | `"eks-worker-pool"` | no |
| <a name="input_iam_role_policy_attachment_arns"></a> [iam\_role\_policy\_attachment\_arns](#input\_iam\_role\_policy\_attachment\_arns) | List of additionnal policy arns that will be attached to the role of the worker pool nodes. | `list` | `[]` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | Map of tags that will be added on the IAM role. | `map` | `{}` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | ID of the AMI that will be used for the worker nodes. NOTE: Leave empty to use `ami_name` variable. | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance that will be used for the worker pool nodes. | `string` | `"t3.small"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the AWS Key pair to attach to the instances. | `string` | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of the EKS cluster. Will be used to determine which AMI to use for eks worker nodes. NOTE: If ami is set, this will be ignored. | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix to use for the launch configuration of the worker pool. | `string` | `"eks-worker-pool"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group ids that will be attached to the worker pool nodes. | `list` | `[]` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group for the worker pool nodes. | `string` | `"eks-worker-pool"` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | Map of tags that will be applied on the security group for the worker pool nodes. | `map` | `{}` | no |
| <a name="input_spot_price"></a> [spot\_price](#input\_spot\_price) | The maximum price to use for reserving spot instances. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet ID's that will be used to deploy the EKS worker pool. | `list(any)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags that will be added on all resources. | `map` | `{}` | no |
| <a name="input_use_max_pods"></a> [use\_max\_pods](#input\_use\_max\_pods) | Maximum number of pods that will be allowed to be scheduled on each node. | `bool` | `false` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Root block device volume size. | `number` | `50` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Root block device volume type. | `string` | `"standard"` | no |
| <a name="input_worker_pool_security_group_ids"></a> [worker\_pool\_security\_group\_ids](#input\_worker\_pool\_security\_group\_ids) | List of security group ids of the other worker pools available on the cluster. | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | ARN of the autoscaling group that is created. |
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | ID of the autoscaling group that is created. |
| <a name="output_aws_auth_data"></a> [aws\_auth\_data](#output\_aws\_auth\_data) | List of maps representing the needed config to add to the aws-auth configmap on EKS. |
| <a name="output_iam_instance_profile_arn"></a> [iam\_instance\_profile\_arn](#output\_iam\_instance\_profile\_arn) | ARN of the IAM instance profile that is created. |
| <a name="output_iam_instance_profile_id"></a> [iam\_instance\_profile\_id](#output\_iam\_instance\_profile\_id) | ID of the IAM instance profile that is created. |
| <a name="output_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#output\_iam\_instance\_profile\_name) | Name of the IAM instance profile that is created. |
| <a name="output_iam_instance_profile_unique_id"></a> [iam\_instance\_profile\_unique\_id](#output\_iam\_instance\_profile\_unique\_id) | Uniauq ID of the IAM instance profile that is created. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of the IAM role that is created. |
| <a name="output_iam_role_id"></a> [iam\_role\_id](#output\_iam\_role\_id) | ID of the IAM role that is created. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of the IAM role that is created. |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Uniauq ID of the IAM role that is created. |
| <a name="output_launch_configuration_id"></a> [launch\_configuration\_id](#output\_launch\_configuration\_id) | ID of the launch configruation that is created. |
| <a name="output_launch_configuration_name"></a> [launch\_configuration\_name](#output\_launch\_configuration\_name) | Name of the launch configruation that is created. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
