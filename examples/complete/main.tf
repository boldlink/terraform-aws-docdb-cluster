resource "random_string" "master_username" {
  length  = 6
  special = false
  upper   = false
  numeric = false
}

resource "random_password" "master_password" {
  length  = 16
  special = false
  upper   = false
}

module "kms_key" {
  source      = "boldlink/kms/aws"
  description = "kms key for ${local.cluster_name}"
  alias_name  = "alias/${local.cluster_name}-key-alias"
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}

module "complete_cluster" {
  #checkov:skip=CKV_AWS_104: "Ensure DocDB has audit logs enabled"
  source                         = "./../../"
  availability_zones             = data.aws_availability_zones.available.names
  cluster_identifier             = local.cluster_name
  master_username                = random_string.master_username.result
  master_password                = random_password.master_password.result
  kms_key_id                     = join("", module.kms_key.*.arn)
  vpc_id                         = module.docdb_vpc.id
  create_security_group          = true
  sg_name                        = "${local.cluster_name}-securitygroup"
  identifier                     = "${local.cluster_name}-instance"
  subnet_ids                     = flatten(module.docdb_vpc.private_subnet_id)
  create_cluster_parameter_group = true
  name                           = "${local.cluster_name}-parameter-group"
  allowed_cidr_blocks            = [local.cidr_block]
  cluster_parameters = [
    {
      name         = "audit_logs"
      value        = "enabled"
      apply_method = "immediate"
    },
    {
      name         = "tls"
      value        = "enabled"
      apply_method = "pending-reboot"
    },
    {
      name         = "ttl_monitor"
      value        = "enabled"
      apply_method = "pending-reboot"
    },
    {
      name         = "profiler_threshold_ms"
      value        = 100
      apply_method = "pending-reboot"
    }
  ]

  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
  depends_on = [
    module.docdb_vpc
  ]
}

module "docdb_vpc" {
  source               = "git::https://github.com/boldlink/terraform-aws-vpc.git?ref=2.0.3"
  name                 = "${local.cluster_name}-vpc"
  account              = data.aws_caller_identity.current.account_id
  region               = data.aws_region.current.name
  cidr_block           = local.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  private_subnets      = local.docdb_subnets
  availability_zones   = local.azs
}
