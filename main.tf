# Configuração do provedor AWS
provider "aws" {
  region = var.aws_region
}

# Chamada do módulo VPC
module "vpc" {
  source = "./modules/vpc"

  cidr_block           = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# Chamada do módulo S3
module "s3" {
  source = "./modules/s3"

  bucket_name = var.s3_bucket_name
}

# Chamada do módulo EC2
module "ec2" {
  source = "./modules/ec2"

  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_key_name
  vpc_id        = module.vpc.vpc_id
  subnet_id     = element(module.vpc.public_subnet_ids, 0)
  candidate_ip  = var.candidate_ip
  s3_bucket_arn = module.s3.bucket_arn
}

# Chamada do módulo RDS
module "rds" {
  source = "./modules/rds"

  db_name         = var.rds_db_name
  db_username     = var.rds_db_username
  db_password     = var.rds_db_password
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  security_group_ids = [module.ec2.security_group_id]
}
