locals {
  //    Logic for AZs is azs variable > az_num variable > max azs for region
  az_num = chunklist(data.aws_availability_zones.available.names, var.num_azs)[0]
  az_max = data.aws_availability_zones.available.names
  azs    = coalescelist(var.azs, local.az_num, local.az_max)

  num_azs      = length(local.azs)
  subnet_num   = 2
  subnet_count = local.subnet_num * local.num_azs

  subnet_bits = ceil(log(local.subnet_count, 2))

  public_subnets = [for subnet_num in range(local.num_azs) : cidrsubnet(
    var.cidr,
    local.subnet_bits,
  subnet_num)]

  private_subnets = [for subnet_num in range(local.num_azs) : cidrsubnet(
    var.cidr,
    local.subnet_bits,
    local.num_azs + subnet_num,
  )]
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"
  name   = var.vpc_name

  tags = var.tags

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs  = local.azs
  cidr = var.cidr

  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.id}" = "shared"
    "kubernetes.io/role/elb"          = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.id}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
