[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-docdb/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-docdb.svg)](https://github.com/boldlink/terraform-aws-docdb/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-docdb/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-docdb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-docdb/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-docdb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-docdb/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-docdb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-docdb/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-docdb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-docdb/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-docdb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-docdb/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-docdb/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-docdb/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-docdb/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

## Description
This Terraform module Manages a DocDB Cluster.

Examples available [here](https://github.com/boldlink/terraform-aws-docdb/tree/main/examples)

## Usage
*NOTE*: These examples use the latest version of this module

```console
module "complete_cluster" {
  source                    = "./../../"
  cluster_identifier        = local.cluster_name
  availability_zones        = data.aws_availability_zones.available.names
  identifier                = "${local.cluster_name}-instance"
  instance_class            = "db.t3.medium"
  instance_count            = local.count
  final_snapshot_identifier = "${local.cluster_name}-final-snapshot"
  master_username           = random_string.master_username.result
  master_password           = random_password.master_password.result
  subnet_ids                = data.aws_subnets.default.ids
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}
```
## Documentation

[AWS DocumentDB Cluster Documentation ](https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-create.html)

[Terraform DocumentDB Cluster Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.15.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_docdb_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) | resource |
| [aws_docdb_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance) | resource |
| [aws_docdb_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group) | resource |
| [aws_docdb_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_subnet_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks allowed to access the cluster | `list(string)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | (Optional) Specifies whether any cluster or database modifications are applied immediately, or during the next maintenance window. Default is false. | `string` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | (Optional) Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default true | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Optional, Computed) The EC2 Availability Zone that the DB instance is created in. | `string` | `null` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (Optional) A list of EC2 Availability Zones that instances in the DB cluster can be created in. | `list(string)` | `[]` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | (Optional) The days to retain backups for. Default 1 | `number` | `7` | no |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | List of CIDR blocks | `string` | `"0.0.0.0/0"` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | (Optional, Forces new resources) The cluster identifier. If omitted, Terraform will assign a random, unique identifier. | `string` | `null` | no |
| <a name="input_cluster_identifier_prefix"></a> [cluster\_identifier\_prefix](#input\_cluster\_identifier\_prefix) | (Optional, Forces new resource) Creates a unique cluster identifier beginning with the specified prefix. Conflicts with cluster\_identifier. | `string` | `null` | no |
| <a name="input_cluster_parameters"></a> [cluster\_parameters](#input\_cluster\_parameters) | (Optional) A list of documentDB parameters to apply. Setting parameters to system default values may show a difference on imported resources. | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_timeouts"></a> [cluster\_timeouts](#input\_cluster\_timeouts) | aws\_docdb\_cluster provides the following Timeouts configuration options: create, update, delete | <pre>list(object({<br>    create = string<br>    update = string<br>    delete = string<br>  }))</pre> | `[]` | no |
| <a name="input_create_cluster_parameter_group"></a> [create\_cluster\_parameter\_group](#input\_create\_cluster\_parameter\_group) | Whether to create cluster parameter group | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a Security Group for DocDB cluster. | `bool` | `false` | no |
| <a name="input_db_cluster_parameter_group_name"></a> [db\_cluster\_parameter\_group\_name](#input\_db\_cluster\_parameter\_group\_name) | (Optional) A cluster parameter group to associate with the cluster. | `string` | `null` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | (Optional) A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. | `bool` | `false` | no |
| <a name="input_egress_protocol"></a> [egress\_protocol](#input\_egress\_protocol) | (Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"-1"` | no |
| <a name="input_egress_type"></a> [egress\_type](#input\_egress\_type) | (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound) | `string` | `"egress"` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | (Optional) List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, profiler | `list(string)` | <pre>[<br>  "audit",<br>  "profiler"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | (Optional) The name of the database engine to be used for this DB cluster and instance. Defaults to docdb. Valid Values: docdb | `string` | `"docdb"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (Optional) The database engine version. Updating this argument results in an outage. | `string` | `null` | no |
| <a name="input_family"></a> [family](#input\_family) | (Required, Forces new resource) The family of the documentDB cluster parameter group. | `string` | `"docdb4.0"` | no |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | (Required) Start port (or ICMP type number if protocol is 'icmp' or 'icmpv6') | `number` | `0` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | (Optional, Forces new resource) The identifier for the DocDB instance, if omitted, Terraform will assign a random, unique identifier. | `string` | `null` | no |
| <a name="input_identifier_prefix"></a> [identifier\_prefix](#input\_identifier\_prefix) | (Optional, Forces new resource) Creates a unique identifier beginning with the specified prefix. Conflicts with identifier | `string` | `null` | no |
| <a name="input_ingress_protocol"></a> [ingress\_protocol](#input\_ingress\_protocol) | (Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"tcp"` | no |
| <a name="input_ingress_type"></a> [ingress\_type](#input\_ingress\_type) | (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound) | `string` | `"ingress"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | (Required) The instance class to use. For details on CPU and memory, see Scaling for DocDB Instances. db.r5.large, db.r5.xlarge ,db.r5.2xlarge, db.r5.4xlarge, db.r5.12xlarge, db.r5.24xlarge, db.r4.large, db.r4.xlarge, db.r4.2xlarge, db.r4.4xlarge, db.r4.8xlarge, db.r4.16xlarge, db.t3.medium | `string` | `"db.t3.medium"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of DocumentDB cluster instances to be created. | `number` | `3` | no |
| <a name="input_instance_timeouts"></a> [instance\_timeouts](#input\_instance\_timeouts) | aws\_docdb\_cluster\_instance provides the following Timeouts configuration options: create, update, delete | <pre>list(object({<br>    create = string<br>    update = string<br>    delete = string<br>  }))</pre> | `[]` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | (Optional) The ARN for the KMS encryption key. When specifying kms\_key\_id, storage\_encrypted needs to be set to true. | `string` | `null` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | (Required unless a snapshot\_identifier or unless a global\_cluster\_identifier is provided when the cluster is the 'secondary' cluster of a global database) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. | `string` | n/a | yes |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | (Required unless a snapshot\_identifier or unless a global\_cluster\_identifier is provided when the cluster is the 'secondary' cluster of a global database) Username for the master DB user | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional, Forces new resource) The name of the documentDB cluster parameter group. If omitted, Terraform will assign a random, unique name. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name. | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | (Optional) The port on which the DB accepts connections | `number` | `27017` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | (Optional) The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC Default: A 30-minute window selected at random from an 8-hour block of time per regionE.g., 04:00-09:00 | `string` | `"04:00-05:00"` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | (Optional) The weekly time range during which system maintenance can occur, in (UTC) e.g., wed:04:00-wed:04:30 | `string` | `"sun:01:00-sun:03:30"` | no |
| <a name="input_promotion_tier"></a> [promotion\_tier](#input\_promotion\_tier) | (Optional) Default 0. Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoter to writer. | `number` | `0` | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | (Optional, Forces new resource) Name of the security group. If omitted, Terraform will assign a random, unique name. | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | (Optional) Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted, using the value from final\_snapshot\_identifier. Default is false. | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | (Optional) Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot. | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | (Optional) Specifies whether the DB cluster is encrypted. The default is false. | `bool` | `true` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Required) A list of VPC subnet IDs. | `list(string)` | `[]` | no |
| <a name="input_subnet_name_prefix"></a> [subnet\_name\_prefix](#input\_subnet\_name\_prefix) | (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the DB cluster. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | (Required) End port (or ICMP code if protocol is 'icmp') | `number` | `0` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, Forces new resource) VPC ID | `string` | `null` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | (Optional) List of VPC security groups to associate with the Cluster | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_cert_identifier"></a> [ca\_cert\_identifier](#output\_ca\_cert\_identifier) | (Optional) The identifier of the CA certificate for the DB instance. |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_cluster_members"></a> [cluster\_members](#output\_cluster\_members) | List of DocDB Instances that are a part of this cluster |
| <a name="output_cluster_resource_id"></a> [cluster\_resource\_id](#output\_cluster\_resource\_id) | The DocDB Cluster Resource ID |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The DNS address of the DocDB instance |
| <a name="output_engine_version"></a> [engine\_version](#output\_engine\_version) | The database engine version |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_id"></a> [id](#output\_id) | The DocDB Cluster Identifier |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | Amazon Resource Name (ARN) of cluster instance |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The ARN for the KMS encryption key if one is set to the cluster. |
| <a name="output_port"></a> [port](#output\_port) | The database port |
| <a name="output_preferred_backup_window"></a> [preferred\_backup\_window](#output\_preferred\_backup\_window) | The daily time range during which automated backups are created if automated backups are enabled. |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas |
| <a name="output_storage_encrypted"></a> [storage\_encrypted](#output\_storage\_encrypted) | Specifies whether the DB cluster is encrypted. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags |
| <a name="output_writer"></a> [writer](#output\_writer) | Boolean indicating if this instance is writable. False indicates this instance is a read replica. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

### Supporting resources:

The example stacks are used by BOLDLink developers to validate the modules by building an actual stack on AWS.

Some of the modules have dependencies on other modules (ex. Ec2 instance depends on the VPC module) so we create them
first and use data sources on the examples to use the stacks.

Any supporting resources will be available on the `tests/supportingResources` and the lifecycle is managed by the `Makefile` targets.

Resources on the `test/supportingResources` folder are not intended for demo or actual implementation purposes, and can be used for reference.

### Makefile
The makefile contain in this repo is optimized for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done separately so you can test your module build/modify/destroy independently.
```console
make cleansupporting
```
* !!!DANGER!!! Clean the state files from examples and test/supportingResources - use with CAUTION!!!
```console
make cleanstatefiles
```

#### BOLDLink-SIG 2022
