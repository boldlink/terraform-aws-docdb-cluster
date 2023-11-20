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

module "docdb_cluster" {
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  source                  = "./../../"
  cluster_identifier      = local.cluster_name
  availability_zones      = local.azs
  identifier              = "${local.cluster_name}-instance"
  master_username         = random_string.master_username.result
  master_password         = random_password.master_password.result
  backup_retention_period = 7
  vpc_id                  = local.vpc_id
  subnet_ids              = local.subnet_ids
  tags                    = local.tags
  security_group_ingress_rules = {
    default = {
      description = "Custom ingress traffic allowed to docdb cluster"
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = [local.vpc_cidr]
    }
  }
}
