# Configuração do banco de dados RDS MySQL

# Criação do Security Group para o RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Security Group para o banco de dados RDS"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Acesso MySQL da EC2"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = var.security_group_ids
  }

  egress {
    description      = "Trafego de saida permitido"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_security_group"
  }
}

# Criação da instância RDS MySQL
resource "aws_db_instance" "rds_instance" {
  identifier        = lower(replace(var.db_name, "_", "-"))
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  #name              = var.db_name
  username          = var.db_username
  password          = var.db_password
  parameter_group_name = "default.mysql8.0"
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot = true

  tags = {
    Name = "MyRDSInstance"
  }
}

# Criação do Subnet Group para o RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "RDS Subnet Group"
  }
}

# Outputs do RDS
output "endpoint" {
  description = "Endpoint do banco de dados RDS MySQL"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_security_group_id" {
  description = "ID do Security Group do RDS"
  value       = aws_security_group.rds_sg.id
}
