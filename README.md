# Terraform-codefy

## Projeto Tecnico Terraform

# Alerta Importante:

Antes de iniciar o provisionamento da infraestrutura, é **fundamental** que você crie um usuário na AWS, Em seguida crie uma chave de acesso na EC2 e Siga as instruções abaixo:

1. **Criar um Usuário na AWS**:
   - Acesse o console da AWS e navegue até o serviço IAM (Identity and Access Management).
   - Crie um novo usuário e atribua as permissões necessárias para que ele possa criar e gerenciar os recursos que você deseja provisionar (como EC2, S3, RDS, etc.).
   - Anote as credenciais de acesso (Access Key ID e Secret Access Key) que serão usadas para configurar o AWS CLI.

2. **Criar uma Chave de Acesso da EC2**:
   - No console da AWS, vá para o serviço EC2.
   - Clique em "Key Pairs" (Chaves de Acesso) e crie uma nova chave de acesso.
   - Salve o arquivo `.pem` gerado em um local seguro, pois você precisará dele para acessar a instância EC2 após o provisionamento.

Certifique-se de que as credenciais e a chave de acesso estejam configuradas corretamente no seu ambiente local para que o Terraform possa se conectar à sua conta AWS e provisionar os recursos necessários.


# Instruções para Executar o Terraform

1. **Clone o repositório**:
   ```bash
   git clone <URL_DO_REPOSITORIO>
   cd <NOME_DO_REPOSITORIO>
   ```

2. **Inicialize o Terraform**:
   Execute o comando a seguir para inicializar o Terraform e baixar os provedores necessários:
   ```bash
   terraform init
   ```
 ***Também Inicialize os Módulos (ec2, rds, s3, vpc)***:
   ```bash
   cd modules/ec2

   terraform init
   ```	

3. **Inicialize os Módulos**:
   Após a inicialização do Terraform, você pode inicializar os módulos específicos do ambiente (por exemplo, dev ou prod) com o seguinte comando:
   ```bash
   cd environments/dev

   terraform init
   ```
   Este comando irá garantir que todos os módulos definidos nos arquivos de configuração sejam baixados e configurados corretamente.

4. **Verifique o plano de execução**:
   Antes de aplicar as mudanças, você pode verificar o que será criado com o seguinte comando:
   ```bash
   terraform plan
   ```
 ***Também é possivel Executar o plano dos módulos específicos:***
   ```bash
   terraform plan -var-file="environments/dev/terraform.tfvars"

   terraform plan -var-file="environments/prod/terraform.tfvars"
   ```

5. **Aplique as configurações**:
   Para provisionar a infraestrutura, execute:
   ```bash
   terraform apply
   ```
   Você será solicitado a confirmar a aplicação. Digite `yes` para continuar.

6. **Destrua a infraestrutura (opcional)**:
   Se você quiser remover todos os recursos provisionados, execute:
   ```bash
   terraform apply --destroy
   ```
   Novamente, você será solicitado a confirmar a destruição. Digite `yes` para continuar.

# Infraestrutura Configurada na AWS

Este projeto Terraform configura a seguinte infraestrutura na AWS:

- **VPC**: Uma Virtual Private Cloud (VPC) com sub-redes públicas e privadas para isolar os recursos.
- **Instância EC2**: Uma instância EC2 que executa uma aplicação, configurada com uma role IAM que permite acesso de leitura e escrita a um bucket S3.
- **Bucket S3**: Um bucket S3 para armazenamento de dados, permitindo que a instância EC2 armazene e recupere arquivos.
- **Banco de Dados RDS**: Uma instância de banco de dados RDS MySQL, configurada em uma sub-rede privada para maior segurança.

A infraestrutura é provisionada de forma a garantir que os recursos estejam adequadamente conectados e seguros, utilizando grupos de segurança e políticas de acesso apropriadas.

# Alerta:
Importância dos Arquivos do Ambiente **DEV** e **PROD**

Os arquivos de configuração nos diretórios `environments/dev` e `environments/prod` são essenciais para gerenciar diferentes ambientes de implantação. Aqui estão algumas razões para sua importância:

1. **Isolamento de Ambientes**: Ter configurações separadas para desenvolvimento e produção permite que você teste novas funcionalidades e alterações em um ambiente isolado antes de aplicá-las em produção. Isso ajuda a evitar interrupções no serviço e garante que as alterações sejam testadas adequadamente.

2. **Configurações Específicas**: Cada ambiente pode ter requisitos diferentes. Por exemplo, o ambiente de desenvolvimento pode usar uma instância RDS com uma senha menos complexa ou um tipo de instância menor, enquanto o ambiente de produção deve ter configurações mais robustas e seguras.

3. **Gerenciamento de Senhas e Variáveis Sensíveis**: Os arquivos de configuração permitem que você declare variáveis, como a senha do banco de dados RDS, de forma que cada ambiente possa ter suas próprias credenciais. Isso é crucial para a segurança e para evitar a exposição de informações sensíveis.

4. **Facilidade de Manutenção**: Com a separação dos ambientes, é mais fácil manter e atualizar cada um deles de forma independente, permitindo um ciclo de desenvolvimento mais ágil e eficiente.

---

# Sobre o Script `deploy.sh`

O arquivo `deploy.sh` foi criado para automatizar o processo de inicialização e aplicação da infraestrutura usando Terraform. Ele facilita o provisionamento para diferentes ambientes como **dev**, ** ou **prod**, garantindo padronização e segurança.

---

## Como Funciona

### Navegação ao Diretório do Ambiente
O script acessa o diretório do ambiente informado como argumento (ex.: `prod`).

### Inicialização do Terraform
Prepara o ambiente com `terraform init`.

### Validação
Verifica se os arquivos Terraform estão corretos com `terraform validate`.

### Planejamento e Aplicação
Gera um plano com `terraform plan` e aplica as alterações usando `terraform apply`.

---

## Como Usar

Execute o script passando o nome do ambiente:

```bash
./scripts/deploy.sh <ambiente>
```

----

## Considerações Finais

Para garantir a segurança das informações sensíveis, como senhas e variáveis de ambiente, foi adicionado um arquivo `.gitignore` ao repositório. Este arquivo impede que todos os arquivos com a extensão `.tfvars` sejam rastreados pelo Git, evitando que informações confidenciais sejam expostas no repositório.

```plaintext
# Ignorar arquivos de variáveis sensíveis
*.tfvars
```


Se você já adicionou arquivos `.tfvars` ao repositório antes de configurar o `.gitignore`, você precisará removê-los do índice do Git. Para fazer isso, execute o seguinte comando:

```bash
git rm --cached "caminho/do/arquivo.tfvars"
```

Substitua `"caminho/do/arquivo.tfvars"` pelo caminho real do arquivo que você deseja remover. Isso irá remover o arquivo do controle de versão, mas manterá o arquivo localmente em sua máquina.

---

# **Estimativa de Custos da Infraestrutura na AWS**

## **VPC e NAT Gateway**
## Localização: Leste dos EUA (N. da Virgínia)
| **Recurso**                     | **Descrição**                                        | **Quantidade** | **Custo Mensal (USD)**       |
|----------------------------------|------------------------------------------------------|----------------|------------------------------|
| **VPC com Sub-redes**            | 1 VPC com: 2 sub-redes públicas e 2 privadas         | 1              | -                            |
| **Internet Gateway (IGW)**      | Acesso à internet para sub-redes públicas            | 1              | 0 (cobrança por tráfego)      |
| **NAT Gateway**                  | 2 NAT Gateways para sub-redes privadas               | 2              | $66,60                       |
| **NAT Gateway (Processamento de Dados)** | Processamento de dados (10 GB por mês)             | 2              | $0,45                        |
| **Total**                        | Total de custos para VPC e NAT Gateway               | 2              | **$66,60**                   |

# Explicação:
- **VPC com Sub-redes**: Uma VPC foi configurada com 2 sub-redes públicas e 2 privadas, conforme solicitado.
- **Internet Gateway (IGW)**: Acesso à internet para as sub-redes públicas, mas sem custo adicional, pois o IGW é gratuito (exceto pelo tráfego).
- **NAT Gateway**: Usado para permitir o tráfego de saída das sub-redes privadas para a internet. Dois NAT Gateways são usados para alta disponibilidade (1 por AZ).
- **Custo de Processamento de Dados**: Cálculo do tráfego processado pelos NAT Gateways (10 GB por mês em cada NAT Gateway).

----
# **Instancia EC2** 
## Localização: Leste dos EUA (N. da Virgínia)
| **Recurso**                   | **Descrição**                                                        | **Quantidade** | **Custo Mensal (USD)** |
|---------------------------|------------------------------------------------------------------|------------|---------------------|
| EC2 Instance Savings Plans | Instância EC2 t2.micro com Savings Plans (3 anos, No Upfront)    | 1          | $3,65               |

----
# **Amazon Simple Storage Service (S3)**
## Localização: Leste dos EUA (N. da Virgínia)
| **Recurso**                      | **Descrição**                                                      | **Quantidade** | **Custo Mensal (USD)** |
|------------------------------|----------------------------------------------------------------|------------|---------------------|
| S3 Storage (Standard)         | Armazenamento de 10 GB no S3 Standard                         | 10 GB      | $0,23               |
| S3 PUT Requests               | 10 solicitações PUT (S3 Standard)                             | 10         | $0,0001             |
| S3 GET Requests               | 10 solicitações GET (S3 Standard)                             | 10         | $0,00               |
| S3 Select (Data Scanning)     | 10 GB de dados processados no S3 Select (leitura)            | 10 GB      | $0,007              |
| S3 Select (Data Retrieval)    | Custo de verificação dos dados no S3 Select                   | 10 GB      | $0,02               |
| **Total**                     | Custo total do armazenamento e solicitações no S3 Standard   | -          | $0,26               |

----
# **RDS for MySQL** 
## Localização: Leste dos EUA (N. da Virgínia)
| **Recurso**                      | **Descrição**                                                      | **Quantidade** | **Custo Mensal (USD)** |
|------------------------------|----------------------------------------------------------------|------------|---------------------|
| RDS MySQL (db.t3.micro)       | Instância MySQL com 2 vCPUs e 1 GiB de memória                | 1 instância| $24,82              |
| Armazenamento RDS             | Armazenamento de dados (20 GB)                                | 20 GB      | $4,60               |
| Armazenamento de Backup       | Armazenamento adicional de backup (20 GB)                     | 20 GB      | $1,90               |
| **Total**                     | Custo total mensal do RDS MySQL                               | -          | $31,32              |

----


# **Resumo da Análise de Custo da Infraestrutura Provisionada**

A infraestrutura foi configurada para atender aos requisitos do projeto, que envolvem recursos como VPC, EC2, S3 e RDS MySQL, conforme as boas práticas indicadas. Vamos revisar os custos de cada recurso e como eles se encaixam nas necessidades do projeto:

## **VPC com Sub-redes**:
- Foi criada uma VPC com 2 sub-redes públicas e 2 sub-redes privadas, com tabelas de rotas configuradas para permitir acesso à internet somente nas sub-redes públicas. O uso de NAT Gateways permite que as sub-redes privadas acessem a internet de forma segura.
  - **Custo Total do NAT Gateway:** $66,60
  - **Custo do Processamento de Dados (10 GB por mês em cada NAT Gateway):** $0,45
  - **Custo Total para a Infraestrutura de VPC e NAT Gateway:** $66,60
  
**Análise:** O custo de $66,60 é necessário para garantir alta disponibilidade e segurança nas sub-redes privadas. Porém, é possível reduzir os custos se a alta disponibilidade não for essencial, utilizando apenas um NAT Gateway ou alternativas como instâncias NAT.

## **EC2 Instance (t2.micro com Savings Plans)**:
- Provisionada uma instância EC2 em uma sub-rede pública com acesso SSH restrito ao IP do candidato e tráfego HTTP/HTTPS habilitado.
  - **Custo Total da EC2 (Savings Plans):** $3,65

**Análise:** O Savings Plan oferece um custo reduzido, o que torna a EC2 t2.micro uma escolha econômica para um ambiente de desenvolvimento ou teste. O custo de $3,65 mensais é bem razoável para o uso de uma instância de pequeno porte com essas configurações.

## **S3 Bucket**:
- Criado um bucket S3 para armazenamento de dados, com configuração de bloqueio de acesso público e habilitação de versionamento.
  - **Custo Total do S3 (10 GB de armazenamento + solicitações PUT/GET):** $0,26

**Análise:** O custo do S3 é muito baixo, tornando-o uma excelente escolha para armazenamento de dados com alta escalabilidade. O custo de $0,26 por 10 GB é praticamente irrelevante no contexto de um projeto pequeno.

## **RDS MySQL (db.t3.micro)**:
- Provisionado um banco de dados MySQL em uma sub-rede privada com credenciais armazenadas de forma segura. O banco é acessado apenas pela instância EC2.
  - **Custo Total do RDS MySQL (instância + armazenamento de dados + backup):** $31,32

**Análise:** O RDS MySQL oferece uma solução gerenciada que elimina a necessidade de gerenciamento manual do banco de dados. O custo de $31,32 mensais é razoável para ambientes de pequeno porte e beneficia a segurança e a facilidade de manutenção.

----

# **Custo Total da Infraestrutura**:

| **Recurso**                       | **Custo Mensal (USD)** |
|------------------------------------|------------------------|
| **VPC e NAT Gateway**              | $66,60                 |
| **Instância EC2 (t2.micro)**       | $3,65                  |
| **Amazon S3 (10 GB)**              | $0,26                  |
| **RDS MySQL (db.t3.micro)**        | $31,32                 |
| **Total Geral**                    | **$101,83**            |

A infraestrutura provisionada tem um custo total mensal de **$101,83**. Esse valor é razoável para uma aplicação de pequeno porte ou ambiente de desenvolvimento, considerando que a solução proporciona alta disponibilidade (2 NAT Gateways), gerenciamento de banco de dados simplificado (RDS MySQL) e armazenamento eficiente (S3).

## Vantagens:
- A infraestrutura é bem dimensionada para projetos pequenos ou ambientes de teste.
- O uso de Savings Plans para a instância EC2 e o armazenamento no S3 oferece soluções econômicas.
- A segurança e a facilidade de gerenciamento do banco de dados RDS MySQL justificam o custo.

## Possíveis Melhorias:
- Se a alta disponibilidade para os NAT Gateways não for crítica, é possível reduzir os custos com apenas um NAT Gateway ou explorar alternativas mais baratas para o tráfego entre as sub-redes privadas e a internet.
- O custo do RDS MySQL pode ser revisto caso o projeto necessite de escalabilidade maior ou banco de dados mais robusto.

A infraestrutura é vantajosa para um projeto de pequeno porte ou em estágio inicial, com uma solução escalável e segura para a execução de workloads simples.

