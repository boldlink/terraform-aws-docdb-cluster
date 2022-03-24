
locals {
  cluster_name = "sample-cluster"
  environment  = "test"
  count        = 3
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "random_string" "master_username" {
  length  = 6
  special = false
  upper   = false
  number  = false
}

resource "random_password" "master_password" {
  length  = 16
  special = false
  upper   = false
}

module "docdb_subnet_group" {
  source      = "boldlink/docdb-subnet-group/aws"
  version     = "1.0.0"
  name        = "${local.cluster_name}-subnetgroup-${uuid()}"
  subnet_ids  = data.aws_subnets.default.ids
  environment = local.environment
}

module "kms_key" {
  source              = "boldlink/kms-key/aws"
  version             = "1.0.0"
  description         = "A test kms key for DocDB cluster"
  name                = "${local.cluster_name}-kms-key-${uuid()}"
  alias_name          = "alias/docdb-cluster-key-alias-${uuid()}"
  enable_key_rotation = true
}

module "docdb_cluster" {
  source                          = "./../"
  cluster_identifier              = "${local.cluster_name}-${uuid()}"
  master_username                 = random_string.master_username.result
  master_password                 = random_password.master_password.result
  final_snapshot_identifier       = "${local.cluster_name}-final-snapshot-${uuid()}"
  storage_encrypted               = true
  kms_key_id                      = join("", module.kms_key.*.arn)
  vpc_id                          = data.aws_vpc.default.id
  db_subnet_group_name            = join("", module.docdb_subnet_group.*.id)
  enabled_cloudwatch_logs_exports = ["audit", "profiler"]
  create_security_group           = true
  sg_name                         = "${local.cluster_name}-securitygroup-${uuid()}"
  instance_count              = 2
  identifier         = "${local.cluster_name}-instance"  #-${count.index}"
  instance_class     = "db.t3.medium"
  environment        = local.environment
  create_cluster_parameter_group  = true
  name                            = "${local.cluster_name}-parameter-group-${uuid()}"
  allowed_cidr_blocks             = [data.aws_vpc.default.cidr_block]
  cluster_parameters = [
    {
      name         = "tls"
      value        = "enabled"
      apply_method = "immediate"
    }
  ]
}

output "docdb_cluster" {
  value = [
    module.docdb_cluster,
  ]
}
