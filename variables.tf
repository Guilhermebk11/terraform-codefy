# Declaração de variáveis globais do projeto

# Região da AWS
variable "aws_region" {
  description = "Região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

# CIDR da VPC
variable "vpc_cidr" {
  description = "Bloco CIDR para a VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# CIDRs das sub-redes públicas
variable "public_subnet_cidrs" {
  description = "Blocos CIDR para as sub-redes públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# CIDRs das sub-redes privadas
variable "private_subnet_cidrs" {
  description = "Blocos CIDR para as sub-redes privadas"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Zonas de disponibilidade
variable "availability_zones" {
  description = "Zonas de disponibilidade para as sub-redes"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Nome do bucket S3
variable "s3_bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

# AMI da instância EC2
variable "ec2_ami" {
  description = "ID da AMI para a instância EC2"
  type        = string
}

# Tipo da instância EC2
variable "ec2_instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

# Nome da key pair para EC2
variable "ec2_key_name" {
  description = "Nome da key pair para acesso SSH à instância EC2"
  type        = string
}

# IP do candidato para acesso SSH
variable "candidate_ip" {
  description = "IP do candidato para permitir acesso SSH"
  type        = string
}

# Nome do banco de dados RDS
variable "rds_db_name" {
  description = "Nome do banco de dados RDS MySQL"
  type        = string
}

# Usuário do banco de dados RDS
variable "rds_db_username" {
  description = "Nome de usuário do banco de dados RDS MySQL"
  type        = string
}

# Senha do banco de dados RDS
variable "rds_db_password" {
  description = "Senha do banco de dados RDS MySQL"
  type        = string
  sensitive   = true
}
