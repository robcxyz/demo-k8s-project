
module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"
  name   = var.vpc_name

  tags = var.tags

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs  = var.azs
  cidr = var.cidr

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.id}" = "shared"
    "kubernetes.io/role/elb"          = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.id}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
