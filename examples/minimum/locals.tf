
locals {
  cluster_name  = "example-minimum-cluster"
  cidr_block    = "192.168.0.0/16"
  docdb_subnet1 = cidrsubnet(local.cidr_block, 7, 50)
  docdb_subnet2 = cidrsubnet(local.cidr_block, 7, 60)
  docdb_subnet3 = cidrsubnet(local.cidr_block, 7, 70)
  docdb_subnets = [local.docdb_subnet1, local.docdb_subnet2, local.docdb_subnet3]

  az1 = data.aws_availability_zones.available.names[0]
  az2 = data.aws_availability_zones.available.names[1]
  az3 = data.aws_availability_zones.available.names[2]
  azs = [local.az1, local.az2, local.az3]
}
