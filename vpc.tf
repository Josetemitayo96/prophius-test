module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 3)]
  database_subnets =  [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 6)]
  create_database_subnet_group = true
  enable_nat_gateway   = true
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true

  map_public_ip_on_launch = false

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }

  tags = merge(local.default_tags, {
    CreatedBy = "Temitayo Jose"
    Created   = "2023-10-28"
  })
}

data "aws_availability_zones" "available" {}
