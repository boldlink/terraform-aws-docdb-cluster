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
  availability_zones = data.aws_availability_zones.available.names
  identifier         = "${local.cluster_name}-instance"
  master_username    = random_string.master_username.result
  master_password    = random_password.master_password.result
  vpc_id             = module.docdb_vpc.id
  subnet_ids         = flatten(module.docdb_vpc.private_subnet_id)
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
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
