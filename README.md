## Description
This Terraform module Manages a DocDB Cluster.

Examples available [here](https://github.com/boldlink/terraform-aws-docdb-cluster/tree/main/examples)

## Documentation

[AWS DocumentDB Cluster Documentation ](https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-create.html)
[Terraform DocumentDB Cluster Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_docdb_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) | resource |
| [aws_docdb_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group) | resource |
| [aws_docdb_cluster_snapshot.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_snapshot) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | (Optional) Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is false. | `string` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (Optional) A list of EC2 Availability Zones that instances in the DB cluster can be created in. | `list(string)` | `[]` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | (Optional) The days to retain backups for. Default 1 | `number` | `1` | no |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | List of CIDR blocks | `string` | `"0.0.0.0/0"` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | (Optional, Forces new resources) The cluster identifier. If omitted, Terraform will assign a random, unique identifier. | `string` | `null` | no |
| <a name="input_cluster_identifier_prefix"></a> [cluster\_identifier\_prefix](#input\_cluster\_identifier\_prefix) | (Optional, Forces new resource) Creates a unique cluster identifier beginning with the specified prefix. Conflicts with cluster\_identifier. | `string` | `null` | no |
| <a name="input_cluster_parameters"></a> [cluster\_parameters](#input\_cluster\_parameters) | (Optional) A list of documentDB parameters to apply. Setting parameters to system default values may show a difference on imported resources. | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Used for Cluster creation | `string` | `"120m"` | no |
| <a name="input_create_cluster_parameter_group"></a> [create\_cluster\_parameter\_group](#input\_create\_cluster\_parameter\_group) | Whether to create cluster parameter group | `bool` | `false` | no |
| <a name="input_create_cluster_snapshot"></a> [create\_cluster\_snapshot](#input\_create\_cluster\_snapshot) | Whether to create cluster parameter group | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a Security Group for DocDB cluster. | `bool` | `false` | no |
| <a name="input_db_cluster_identifier"></a> [db\_cluster\_identifier](#input\_db\_cluster\_identifier) | (Required) The DocDB Cluster Identifier from which to take the snapshot. | `string` | n/a | yes |
| <a name="input_db_cluster_parameter_group_name"></a> [db\_cluster\_parameter\_group\_name](#input\_db\_cluster\_parameter\_group\_name) | (Optional) A cluster parameter group to associate with the cluster. | `string` | `null` | no |
| <a name="input_db_cluster_snapshot_identifier"></a> [db\_cluster\_snapshot\_identifier](#input\_db\_cluster\_snapshot\_identifier) | (Required) The Identifier for the snapshot. | `string` | `""` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | (Optional) A DB subnet group to associate with this DB instance. | `string` | `null` | no |
| <a name="input_delete"></a> [delete](#input\_delete) | Used for destroying cluster. This includes any cleanup task during the destroying process. | `string` | `"120m"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | (Optional) A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. | `bool` | `false` | no |
| <a name="input_egress_protocol"></a> [egress\_protocol](#input\_egress\_protocol) | (Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"-1"` | no |
| <a name="input_egress_type"></a> [egress\_type](#input\_egress\_type) | (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound) | `string` | `"egress"` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | (Optional) List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, profiler | `list(string)` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | (Optional) The name of the database engine to be used for this DB cluster. Defaults to docdb. Valid Values: docdb | `string` | `"docdb"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (Optional) The database engine version. Updating this argument results in an outage. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment this resource is being deployed to | `string` | `null` | no |
| <a name="input_family"></a> [family](#input\_family) | (Required, Forces new resource) The family of the documentDB cluster parameter group. | `string` | `"docdb3.6"` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | (Optional) The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made. | `string` | `null` | no |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | (Required) Start port (or ICMP type number if protocol is 'icmp' or 'icmpv6') | `number` | `0` | no |
| <a name="input_ingress_protocol"></a> [ingress\_protocol](#input\_ingress\_protocol) | (Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"tcp"` | no |
| <a name="input_ingress_type"></a> [ingress\_type](#input\_ingress\_type) | (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound) | `string` | `"ingress"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | (Optional) The ARN for the KMS encryption key. When specifying kms\_key\_id, storage\_encrypted needs to be set to true. | `string` | `null` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | (Required unless a snapshot\_identifier or unless a global\_cluster\_identifier is provided when the cluster is the 'secondary' cluster of a global database) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. | `string` | n/a | yes |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | (Required unless a snapshot\_identifier or unless a global\_cluster\_identifier is provided when the cluster is the 'secondary' cluster of a global database) Username for the master DB user | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional, Forces new resource) The name of the documentDB cluster parameter group. If omitted, Terraform will assign a random, unique name. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name. | `string` | `null` | no |
| <a name="input_other_tags"></a> [other\_tags](#input\_other\_tags) | For adding an additional values for tags | `map(string)` | `{}` | no |
| <a name="input_port"></a> [port](#input\_port) | (Optional) The port on which the DB accepts connections | `number` | `27017` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | (Optional) The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC Default: A 30-minute window selected at random from an 8-hour block of time per regionE.g., 04:00-09:00 | `string` | `"07:00-09:00"` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | (Optional) The weekly time range during which system maintenance can occur, in (UTC) e.g., wed:04:00-wed:04:30 | `string` | `"sun:04:00-sun:04:30"` | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | (Optional, Forces new resource) Name of the security group. If omitted, Terraform will assign a random, unique name. | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | (Optional) Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted, using the value from final\_snapshot\_identifier. Default is false. | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | (Optional) Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot. | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | (Optional) Specifies whether the DB cluster is encrypted. The default is false. | `bool` | `false` | no |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | (Required) End port (or ICMP code if protocol is 'icmp') | `number` | `0` | no |
| <a name="input_update"></a> [update](#input\_update) | Used for Cluster modifications | `string` | `"120m"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, Forces new resource) VPC ID | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_cluster_members"></a> [cluster\_members](#output\_cluster\_members) | List of DocDB Instances that are a part of this cluster |
| <a name="output_cluster_resource_id"></a> [cluster\_resource\_id](#output\_cluster\_resource\_id) | The DocDB Cluster Resource ID |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The DNS address of the DocDB instance |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_id"></a> [id](#output\_id) | The DocDB Cluster Identifier |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
