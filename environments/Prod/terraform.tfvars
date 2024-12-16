# Valores das variáveis específicas para o ambiente de produção

aws_region           = "us-east-1"
vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

s3_bucket_name       = "meu-bucket-s3-prod-exemplo"
ec2_ami              = "ami-0c55b159cbfafe1f0" # Substitua pela AMI desejada
ec2_key_name         = "minha-keypair-prod"
candidate_ip         = "123.456.789.012/32" # Substitua pelo seu IP
rds_db_name          = "meubanco_prod"
rds_db_username      = "admin_prod"
rds_db_password      = "senha-super-secreta-prod" # Preferencialmente, utilizar um gerenciador de segredos
