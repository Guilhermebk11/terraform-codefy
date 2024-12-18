# Configurações específicas para o ambiente de desenvolvimento

# Importação do módulo raiz
module "root" {
  source = "../../"

  rds_db_password = var.rds_db_password
}

# Declaração da variável rds_db_password
variable "rds_db_password" {
  description = "Senha do banco de dados RDS"
  type        = string
}
