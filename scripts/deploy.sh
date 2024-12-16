#!/bin/bash
# scripts/deploy.sh
# Script para inicializar e aplicar a infraestrutura Terraform

# Navega até o diretório do ambiente
cd "$(dirname "$0")/../environments/$1"

# Inicializa o Terraform
terraform init

# Valida a configuração
terraform validate

# Planeja a aplicação
terraform plan -out=plan.out

# Aplica o plano
terraform apply "plan.out"
