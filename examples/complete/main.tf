resource "random_string" "master_username" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

resource "random_password" "master_password" {
  length  = 72
  special = false
  upper   = false
}

module "kms_key" {
  source      = "boldlink/kms/aws"
  description = "kms key for ${local.cluster_name}"
  alias_name  = "alias/${local.cluster_name}-key-alias"
  tags        = local.tags
}

module "complete_cluster" {
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  source                         = "./../../"
  availability_zones             = local.azs
  cluster_identifier             = local.cluster_name
  master_username                = random_string.master_username.result
  master_password                = random_password.master_password.result
  kms_key_id                     = module.kms_key.arn
  vpc_id                         = local.vpc_id
  create_security_group          = true
  identifier                     = "${local.cluster_name}-instance"
  subnet_ids                     = local.subnet_ids
  create_cluster_parameter_group = true
  name                           = local.cluster_name
  apply_immediately              = true
  backup_retention_period        = 14
  deletion_protection            = false
  engine_version                 = "5.0.0"
  preferred_backup_window        = "00:00-02:00"
  preferred_maintenance_window   = "fri:03:00-fri:04:00"
  skip_final_snapshot            = true
  storage_encrypted              = true

  cluster_timeouts = {
    create = "60m"
    update = "60m"
    delete = "60m"
  }

  instance_timeouts = {
    create = "60m"
    update = "60m"
    delete = "60m"
  }

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

  security_group_ingress_rules = {
    default = {
      description = "Custom ingress traffic allowed to docdb cluster"
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = [local.vpc_cidr]
    }
  }

  security_group_egress_rules = {
    default = {
      description = "Custom egress traffic allowed to docdb cluster"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [local.vpc_cidr]
    }
  }

  tags = local.tags
}

resource "aws_docdb_cluster_snapshot" "snapshot" {
  db_cluster_identifier          = module.complete_cluster.id
  db_cluster_snapshot_identifier = "${local.cluster_name}-snap-0123"
}

resource "aws_docdb_cluster_parameter_group" "external" {
  name        = "docdb-cluster-pg"
  family      = "docdb5.0"
  description = "DocDB cluster parameter group"

  parameter {
    name         = "audit_logs"
    value        = "enabled"
    apply_method = "immediate"
  }

  parameter {
    name         = "tls"
    value        = "enabled"
    apply_method = "pending-reboot"
  }
}

module "external_parameter_group" {
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  source                          = "./../../"
  availability_zones              = local.azs
  cluster_identifier_prefix       = var.prefix
  master_username                 = random_string.master_username.result
  master_password                 = random_password.master_password.result
  kms_key_id                      = module.kms_key.arn
  vpc_id                          = local.vpc_id
  create_security_group           = true
  identifier                      = "${var.prefix}-pg-instance"
  subnet_ids                      = local.subnet_ids
  name                            = var.prefix
  skip_final_snapshot             = true
  storage_encrypted               = true
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.external.id
  snapshot_identifier             = aws_docdb_cluster_snapshot.snapshot.db_cluster_snapshot_identifier
  promotion_tier                  = "2"

  security_group_ingress_rules = {
    default = {
      description = "Custom ingress traffic allowed to docdb cluster"
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = [local.vpc_cidr]
    }
  }

  security_group_egress_rules = {
    default = {
      description = "Custom egress traffic allowed to docdb cluster"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [local.vpc_cidr]
    }
  }

  tags = local.tags
}
