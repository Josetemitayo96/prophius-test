module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.name

  engine            = "mysql"
  family               = "mysql8.0"
  major_engine_version = "8.0"   
  engine_version    = "8.0"
  instance_class    = "db.t4g.micro"
  allocated_storage = 30
  max_allocated_storage = 100
  db_name  = local.name
  username = local.name
  port     = 3306
  manage_master_user_password = true

  multi_az               = true
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.security_group.security_group_id]
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 1

  tags = merge(local.default_tags, {
    CreatedBy = "Temitayo Jose"
    Created   = "2023-10-28"
  })

}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name
  description = "Complete MySQL example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  tags = merge(local.default_tags, {
    CreatedBy = "Temitayo Jose"
    Created   = "2023-10-28"
  })
}