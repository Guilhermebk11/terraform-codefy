# Declaração das variáveis específicas do módulo EC2

# AMI da instância EC2
variable "ami" {
  description = "ID da AMI para a instância EC2"
  type        = string
}

# Tipo da instância EC2
variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

# Nome da key pair para EC2
variable "key_name" {
  description = "Nome da key pair para acesso SSH à instância EC2"
  type        = string
}

# ID da VPC onde a EC2 será criada
variable "vpc_id" {
  description = "ID da VPC onde a instância EC2 será criada"
  type        = string
}

# ID da sub-rede onde a EC2 será criada
variable "subnet_id" {
  description = "ID da sub-rede onde a instância EC2 será criada"
  type        = string
}

# IP do candidato para acesso SSH
variable "candidate_ip" {
  description = "IP do candidato para permitir acesso SSH"
  type        = string
}

# ARN do bucket S3 para a IAM Role
variable "s3_bucket_arn" {
  description = "ARN do bucket S3 para permitir acesso na IAM Role"
  type        = string
}
