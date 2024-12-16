# Declaração das variáveis específicas do módulo RDS

# Nome do banco de dados RDS
variable "db_name" {
  description = "Nome do banco de dados RDS MySQL"
  type        = string
}

# Nome de usuário do banco de dados RDS
variable "db_username" {
  description = "Nome de usuário do banco de dados RDS MySQL"
  type        = string
}

# Senha do banco de dados RDS
variable "db_password" {
  description = "Senha do banco de dados RDS MySQL"
  type        = string
  sensitive   = true
}

# ID da VPC onde o RDS será criado
variable "vpc_id" {
  description = "ID da VPC onde o banco de dados RDS será criado"
  type        = string
}

# IDs das sub-redes privadas para o RDS
variable "subnet_ids" {
  description = "IDs das sub-redes privadas para o banco de dados RDS"
  type        = list(string)
}

# IDs dos Security Groups que podem acessar o RDS
variable "security_group_ids" {
  description = "IDs dos Security Groups que podem acessar o RDS"
  type        = list(string)
}