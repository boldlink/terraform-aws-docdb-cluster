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

module "complete_cluster" {
  source             = "./../../"
  cluster_identifier = local.cluster_name
  availability_zones = data.aws_availability_zones.available.names
  identifier         = "${local.cluster_name}-instance"
  master_username    = random_string.master_username.result
  master_password    = random_password.master_password.result
  subnet_ids         = data.aws_subnets.default.ids
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}
