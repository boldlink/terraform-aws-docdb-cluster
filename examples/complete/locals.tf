
locals {
  cluster_name              = "example-complete-cluster"
  supporting_resources_name = "terraform-aws-docdb"
  vpc_id                    = data.aws_vpc.supporting.id
  subnet_ids                = flatten(data.aws_subnets.private.ids)
  azs                       = [for subnet in data.aws_subnet.private : subnet.availability_zone]
  tags                      = merge({ "Name" = local.cluster_name }, var.tags)
}
