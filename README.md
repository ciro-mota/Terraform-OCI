# Terraform-OCI

![image](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=black) 
![image](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![image](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![image](https://img.shields.io/badge/Cent%20OS-262577?style=for-the-badge&logo=CentOS&logoColor=white)
![image](https://img.shields.io/badge/Red%20Hat-EE0000?style=for-the-badge&logo=redhat&logoColor=white)
![image](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

## Disclaimer:

Este Git destina-se aos estudos do Terraform com a Oracle OCI. Modificações serão feitas à medida que os estudos forem avançando e descobertas forem sendo feitas.

Pull Requests também são muito bem-vindos.

## Propósito:

Este código provisiona uma instância na OCI com o Ubuntu 20.04 e tipo de máquina padrão _Always Free_.

## Antes de Executar:

1. É necessário obter algumas credenciais para preencher os valores das variáveis acima para a execução do Terraform. Esses valores são obtidos diretamente do Console da OCI Cloud:

- **tenancy_ocid**:

Logue-se na sua conta Console da OCI Cloud e em seguida acesse [este endereço](https://cloud.oracle.com/tenancy). Em **OCID** clique em **Copy** ou **Show**, copie e cole em um bloco de notas.

![](/images/tenancy.png)

- **compartment_ocid**:

Menu Principal -> Identity & Security -> Compartments -> Crie ou escolha um Compartment que irá abrigar a sua instância. Em **OCID** clique em **Copy** ou **Show**, copie e cole em um bloco de notas.

![](/images/compartment.png)

- **user_ocid**:

Menu Principal -> Identity & Security -> Users -> 	oracleidentitycloudservice/\<<seu-email\>>. Em **OCID** clique em **Copy** ou **Show**, copie e cole em um bloco de notas.

![](/images/user.png)

- Execute os comandos abaixo para geração de um par de chaves necessário para autenticação:

```bash
mkdir ~/.oci
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
chmod go-rwx ~/.oci/oci_api_key.pem
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
```

- **fingerprint**:

Capture a `public_key` gerada no passo anterior (`cat ~/.oci/oci_api_key_public.pem`) -> acesse Menu Principal -> Identity & Security -> Users -> 	oracleidentitycloudservice/\<<seu-email\>> -> API Keys -> Add API Key -> Paste Public Key e cole o conteúdo da chave pública.

Com isso será gerado o seu **fingerprint**, copie e cole em um bloco de notas.

![](/images/fingerprint.png)

- **region**:

Certifique-se de qual é a Região utilizada na sua conta. Você consegue esse valor através do campo "Tenancy details", executado no primeiro passo.

- **SSH**:

É necessário um par de chaves para acesso SSH à instância. Gere um novo par com o comando `ssh-keygen -b 2048 -t rsa`.

2. Adicione algumas variáveis ao seu arquivo `.bashrc` ou `.zshrc` preenchendo-as com os valores obtidos anteriormente:

```bash
export TF_VAR_tenancy_ocid=<suas credenciais>
export TF_VAR_compartment_ocid=<suas credenciais>
export TF_VAR_user_ocid=<suas credenciais>
export TF_VAR_fingerprint=<suas credenciais>
export TF_VAR_private_key_path=~/.oci/oci_api_key.pem
export TF_VAR_public_key_path=$(cat /home/seu-usuário/.ssh/id_rsa.pub)
export TF_VAR_region=<suas credenciais>
```

## Execução:

1. Instale o Terraform pelo seu método preferido.
2. Clone este Git.
3. Modifique se necessário.
4. Rode os comandos `terraform init`, `terraform plan -out= nome-do-plano` e `terraform apply`. Por fim, `terraform destroy` para exclusão do que foi criado na OCI.

## Observação:

Caso ocorra algum erro de permissão na execução, proceda com a [instalação do OCI-CLI conforme documentação](https://www.oracle.com/br/technical-resources/articles/cloudcomp/utilizando-oci-cli-p1.html).