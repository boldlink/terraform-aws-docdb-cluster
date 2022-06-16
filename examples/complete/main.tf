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
  source                         = "./../../"
  availability_zones             = data.aws_availability_zones.available.names
  cluster_identifier             = local.cluster_name
  master_username                = random_string.master_username.result
  master_password                = random_password.master_password.result
  kms_key_id                     = join("", module.kms_key.*.arn)
  vpc_id                         = data.aws_vpc.default.id
  create_security_group          = true
  sg_name                        = "${local.cluster_name}-securitygroup"
  identifier                     = "${local.cluster_name}-instance"
  subnet_ids                     = data.aws_subnets.default.ids
  create_cluster_parameter_group = true
  name                           = "${local.cluster_name}-parameter-group"
  allowed_cidr_blocks            = [data.aws_vpc.default.cidr_block]
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
}
