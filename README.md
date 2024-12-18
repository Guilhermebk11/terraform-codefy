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
