# Definição dos outputs globais do projeto

# Output do IP público da instância EC2
output "ec2_public_ip" {
  description = "Endereço IP público da instância EC2"
  value       = module.ec2.instance_public_ip
}

# Output do endpoint do RDS
output "rds_endpoint" {
  description = "Endpoint do banco de dados RDS MySQL"
  value       = module.rds.endpoint
}

# Output do bucket S3 ARN
output "s3_bucket_arn" {
  description = "ARN do bucket S3"
  value       = module.s3.bucket_arn
}