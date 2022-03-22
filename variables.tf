
variable "apply_immediately" {
  description = "(Optional) Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is false."
  type        = string
  default     = false
}

variable "availability_zones" {
  description = "(Optional) A list of EC2 Availability Zones that instances in the DB cluster can be created in."
  type        = list(string)
  default     = []
}

variable "backup_retention_period" {
  description = "(Optional) The days to retain backups for. Default 1"
  type        = number
  default     = 1
}

variable "cluster_identifier_prefix" {
  description = "(Optional, Forces new resource) Creates a unique cluster identifier beginning with the specified prefix. Conflicts with cluster_identifier."
  type        = string
  default     = null
}

variable "cluster_identifier" {
  description = "(Optional, Forces new resources) The cluster identifier. If omitted, Terraform will assign a random, unique identifier."
  type        = string
  default     = null
}

variable "db_subnet_group_name" {
  description = "(Optional) A DB subnet group to associate with this DB instance."
  type        = string
  default     = null
}

variable "db_cluster_parameter_group_name" {
  description = "(Optional) A cluster parameter group to associate with the cluster."
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "(Optional) A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled."
  type        = bool
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  description = "(Optional) List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, profiler"
  type        = list(string)
  default     = []
}

variable "engine_version" {
  description = "(Optional) The database engine version. Updating this argument results in an outage."
  type        = string
  default     = null
}

variable "engine" {
  description = "(Optional) The name of the database engine to be used for this DB cluster. Defaults to docdb. Valid Values: docdb"
  type        = string
  default     = "docdb"
}

variable "final_snapshot_identifier" {
  description = "(Optional) The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made."
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "(Optional) The ARN for the KMS encryption key. When specifying kms_key_id, storage_encrypted needs to be set to true."
  type        = string
  default     = null
}
variable "master_password" {
  description = "(Required unless a snapshot_identifier or unless a global_cluster_identifier is provided when the cluster is the 'secondary' cluster of a global database) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
  type        = string
}

variable "master_username" {
  description = "(Required unless a snapshot_identifier or unless a global_cluster_identifier is provided when the cluster is the 'secondary' cluster of a global database) Username for the master DB user"
  type        = string
}
variable "port" {
  description = "(Optional) The port on which the DB accepts connections"
  type        = number
  default     = 27017
}

variable "preferred_backup_window" {
  description = "(Optional) The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC Default: A 30-minute window selected at random from an 8-hour block of time per regionE.g., 04:00-09:00"
  type        = string
  default     = "07:00-09:00"
}

variable "preferred_maintenance_window" {
  description = "(Optional) The weekly time range during which system maintenance can occur, in (UTC) e.g., wed:04:00-wed:04:30"
  type        = string
  default     = "sun:04:00-sun:04:30"
}

variable "skip_final_snapshot" {
  description = "(Optional) Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted, using the value from final_snapshot_identifier. Default is false."
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "(Optional) Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot."
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "(Optional) Specifies whether the DB cluster is encrypted. The default is false."
  type        = bool
  default     = false
}

#Tags

variable "environment" {
  type        = string
  description = "The environment this resource is being deployed to"
  default     = null
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

variable "create" {
  description = "Used for Cluster creation"
  type        = string
  default     = "120m"
}

variable "update" {
  description = "Used for Cluster modifications"
  type        = string
  default     = "120m"
}

variable "delete" {
  description = "Used for destroying cluster. This includes any cleanup task during the destroying process."
  type        = string
  default     = "120m"
}

# Security Group

variable "vpc_id" {
  description = "(Optional, Forces new resource) VPC ID"
  type        = string
  default     = null
}

variable "sg_name" {
  description = " (Optional, Forces new resource) Name of the security group. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "create_security_group" {
  description = "Whether to create a Security Group for DocDB cluster."
  default     = false
  type        = bool
}

variable "ingress_protocol" {
  description = "(Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  type        = string
  default     = "tcp"
}

variable "ingress_type" {
  description = " (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound)"
  type        = string
  default     = "ingress"
}

variable "egress_protocol" {
  description = "(Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  type        = string
  default     = "-1"
}

variable "egress_type" {
  description = " (Required) Type of rule being created. Valid options are ingress (inbound) or egress (outbound)"
  type        = string
  default     = "egress"
}

variable "cidr_blocks" {
  description = "List of CIDR blocks"
  default     = "0.0.0.0/0"
  type        = string
}

variable "from_port" {
  description = "(Required) Start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')"
  type        = number
  default     = 0
}

variable "to_port" {
  description = "(Required) End port (or ICMP code if protocol is 'icmp')"
  type        = number
  default     = 0
}

# Cluster Parameter Group

variable "create_cluster_parameter_group" {
  description = "Whether to create cluster parameter group"
  type        = bool
  default     = false
}

variable "name" {
  description = "(Optional, Forces new resource) The name of the documentDB cluster parameter group. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = null
}

variable "family" {
  description = "(Required, Forces new resource) The family of the documentDB cluster parameter group."
  type        = string
  default     = "docdb3.6"
}

variable "cluster_parameters" {
  description = "(Optional) A list of documentDB parameters to apply. Setting parameters to system default values may show a difference on imported resources."
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
  default = []
}

# DocumentDB cluster snapshot resource
variable "create_cluster_snapshot" {
  description = "Whether to create cluster parameter group"
  type        = bool
  default     = false
}

variable "db_cluster_identifier" {
  description = "(Required) The DocDB Cluster Identifier from which to take the snapshot."
  type        = string
}

variable "db_cluster_snapshot_identifier" {
  description = "(Required) The Identifier for the snapshot."
  type        = string
  default     = ""

}
