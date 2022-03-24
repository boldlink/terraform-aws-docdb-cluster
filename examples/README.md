# examples

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_docdb_cluster"></a> [docdb\_cluster](#module\_docdb\_cluster) | ./../ | n/a |
| <a name="module_kms_key"></a> [kms\_key](#module\_kms\_key) | boldlink/kms-key/aws | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [random_password.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.master_username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_subnets.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_docdb_cluster"></a> [docdb\_cluster](#output\_docdb\_cluster) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
