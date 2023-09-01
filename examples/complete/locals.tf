
locals {
  cluster_name              = "example-complete-cluster"
  supporting_resources_name = "terraform-aws-docdb"
  vpc_id                    = data.aws_vpc.supporting.id
  subnet_ids                = flatten(data.aws_subnets.database.ids)
  azs                       = [for subnet in data.aws_subnet.database : subnet.availability_zone]
  vpc_cidr                  = data.aws_vpc.supporting.cidr_block
  tags                      = merge({ "Name" = local.cluster_name }, var.tags)
}
