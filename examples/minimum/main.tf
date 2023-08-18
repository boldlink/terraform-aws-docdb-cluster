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

module "docdb_cluster" {
  source             = "./../../"
  cluster_identifier = local.cluster_name
  availability_zones = local.azs
  identifier         = "${local.cluster_name}-instance"
  master_username    = random_string.master_username.result
  master_password    = random_password.master_password.result
  vpc_id             = local.vpc_id
  subnet_ids         = local.subnet_ids
  tags               = local.tags
}
