module "docdb_vpc" {
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
