
# #############################################
# DocDB cluster Resource
# #############################################
resource "aws_docdb_cluster" "this" {
  apply_immediately               = var.apply_immediately
  availability_zones              = var.availability_zones
  backup_retention_period         = var.backup_retention_period
  cluster_identifier_prefix       = var.cluster_identifier == null ? var.cluster_identifier_prefix : null
  cluster_identifier              = var.cluster_identifier
  db_subnet_group_name            = aws_docdb_subnet_group.this.id
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  engine_version                  = var.engine_version
  engine                          = var.engine
  final_snapshot_identifier       = var.final_snapshot_identifier
  kms_key_id                      = var.kms_key_id
  master_password                 = var.master_password
  master_username                 = var.master_username
  port                            = var.port
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  skip_final_snapshot             = var.skip_final_snapshot
  snapshot_identifier             = var.snapshot_identifier
  storage_encrypted               = var.storage_encrypted
  tags                            = var.tags
  vpc_security_group_ids          = concat(var.vpc_security_group_ids, [aws_security_group.this.id])
  dynamic "timeouts" {
    for_each = var.cluster_timeouts
    content {
      create = lookup(timeouts.value, "create", "90m")
      update = lookup(timeouts.value, "update", "90m")
      delete = lookup(timeouts.value, "delete", "90m")
    }
  }
}

# #############################################
# DocDB Parameter Group
# #############################################
resource "aws_docdb_cluster_parameter_group" "this" {
  count       = var.create_cluster_parameter_group ? 1 : 0
  name        = var.name
  name_prefix = var.name_prefix
  family      = var.family
  description = "${var.cluster_identifier} parameter group"
  parameter {
    name  = "audit_logs"
    value = "enabled"
  }

  parameter {
    name  = "change_stream_log_retention_duration"
    value = var.change_stream_log_retention_duration
  }

  parameter {
    name  = "profiler"
    value = var.profiler
  }

  parameter {
    name  = "profiler_threshold_ms"
    value = var.profiler_threshold_ms
  }

  parameter {
    name  = "tls"
    value = var.tls
  }

  parameter {
    name  = "ttl_monitor"
    value = var.ttl_monitor
  }

  tags = var.tags
}


# #############################################
# DocDB SubnetGroup Group
# #############################################
resource "aws_docdb_subnet_group" "this" {
  name        = "${var.cluster_identifier}-subnet-group"
  name_prefix = var.subnet_name_prefix
  description = "${var.cluster_identifier} subnet group."
  subnet_ids  = var.subnet_ids
  tags        = var.tags
}

# #############################################
# DocDB Cluster Instance
# #############################################
resource "aws_docdb_cluster_instance" "this" {
  count                        = var.instance_count
  apply_immediately            = var.apply_immediately
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  availability_zone            = var.availability_zone
  cluster_identifier           = aws_docdb_cluster.this.id
  engine                       = var.engine
  identifier                   = "${var.identifier}-${count.index}"
  identifier_prefix            = var.identifier == null ? var.identifier_prefix : null
  instance_class               = var.instance_class
  preferred_maintenance_window = var.preferred_maintenance_window
  promotion_tier               = var.promotion_tier
  tags                         = var.tags
  dynamic "timeouts" {
    for_each = var.instance_timeouts
    content {
      create = lookup(timeouts.value, "create", "90m")
      update = lookup(timeouts.value, "update", "90m")
      delete = lookup(timeouts.value, "delete", "90m")
    }
  }
}

# #############################################
# Security Group for DocDB cluster
# #############################################
resource "aws_security_group" "this" {
  name        = var.sg_name
  vpc_id      = var.vpc_id
  description = "${var.cluster_identifier} Security Group"
  tags        = var.tags
}

resource "aws_security_group_rule" "ingress_sg" {
  count                    = var.create_security_group ? 1 : 0
  type                     = var.ingress_type
  description              = "Allow inbound traffic from existing Security Groups"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = var.ingress_protocol
  source_security_group_id = join("", aws_security_group.this.*.id)
  security_group_id        = join("", aws_security_group.this.*.id)
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  count             = var.create_security_group ? 1 : 0
  type              = var.ingress_type
  description       = "Allow inbound traffic from existing CIDR blocks"
  from_port         = var.port
  to_port           = var.port
  protocol          = var.ingress_protocol
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = join("", aws_security_group.this.*.id)
}

resource "aws_security_group_rule" "egress" {
  count             = var.create_security_group ? 1 : 0
  type              = var.egress_type
  description       = "Allow all egress traffic"
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.egress_protocol
  cidr_blocks       = [var.cidr_blocks]
  security_group_id = join("", aws_security_group.this.*.id)
}
