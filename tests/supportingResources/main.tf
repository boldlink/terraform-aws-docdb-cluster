module "ecs_vpc" {
  source               = "boldlink/vpc/aws"
  version              = "2.0.3"
  name                 = local.name
  account              = local.account_id
  region               = local.region
  cidr_block           = local.cidr_block
  enable_dns_hostnames = true
  private_subnets      = local.private_subnets
  availability_zones   = local.azs
  tags                 = local.tags
}

/*
module "docdb_vpc" {
  #count = local.create_vpc ? 1 : 0
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
*/
