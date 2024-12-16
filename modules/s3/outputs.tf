# Definição dos outputs do módulo S3

output "bucket_id" {
  description = "ID do bucket S3"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.this.arn
}
