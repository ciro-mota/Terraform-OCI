</p>

<table align="right">
 <tr><td><a href="https://github.com/ciro-mota/Terraform-OCI/blob/main/README.md">:us: English</a></td></tr>
 <tr><td><a href="https://github.com/ciro-mota/Terraform-OCI/blob/main/README.pt-br.md">:brazil: Português</a></td></tr>
</table>

# Terraform-OCI

![image](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=black) 
![image](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![image](https://img.shields.io/badge/Red%20Hat-EE0000?style=for-the-badge&logo=redhat&logoColor=white)
![image](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![image](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Last Commit](https://img.shields.io/github/last-commit/ciro-mota/Terraform-OCI?style=for-the-badge)

Provisione uma instância na Oracle OCI com os recursos _Always Free_ e tipo de máquina padrão. Você poderá escolher entre as imagens do Ubuntu 20.04 ou 22.04 ou Oracle Linux.

## Apoio

Se você gostou deste trabalho, por favor me dê uma estrela no GitHub e considere apoiá-lo:

[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.com/donate/?business=VUS6R8TX53NTS&no_recurring=0&currency_code=BRL)

## Requerimentos:

* Terraform.

* Proceda com a [instalação do OCI-CLI conforme documentação oficial](https://www.oracle.com/br/technical-resources/articles/cloudcomp/utilizando-oci-cli-p1.html).

## Antes de Executar:

1. É necessário obter algumas credenciais para preencher os valores de algumas variáveis para a execução do Terraform. Esses valores são obtidos diretamente do Console da OCI Cloud:

- **tenancy_ocid**:

Logue-se na sua conta Console da OCI Cloud e em seguida acesse [este endereço](https://cloud.oracle.com/tenancy). Em **OCID** clique em **Copy** ou **Show**, copie e cole em um bloco de notas.

![](/images/tenancy.png)

- **user_ocid**:

**Menu Principal** » **Identity & Security** » **Users** » **oracleidentitycloudservice/\<<seu-email\>>**. Em **OCID** clique em **Copy** ou **Show**, copie e cole em um bloco de notas.

![](/images/user.png)

- Execute os comandos abaixo para geração de um par de chaves necessário para autenticação:

```bash
mkdir ~/.oci
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
chmod go-rwx ~/.oci/oci_api_key.pem
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
```

- **fingerprint**:

Capture a `public_key` gerada no passo anterior (`cat ~/.oci/oci_api_key_public.pem`) » acesse **Menu Principal** » **Identity & Security** » **Users** » **oracleidentitycloudservice/\<<seu-email\>>** » **API Keys** » **Add API Key** » **Paste Public Key** e cole o conteúdo da chave pública.

Com isso será gerado o seu **fingerprint**, copie e cole em um bloco de notas.

![](/images/fingerprint.png)

- **SSH**:

Pode ser necessário um par de chaves para acesso SSH à instância. Caso não possua, gere um novo par com o comando `ssh-keygen -b 2048 -t rsa`.

- **State Remoto**

Você pode querer armazenar os seus *states* remotamente em um bucket na OCI. Para isso **Menu Principal** » **Storage** » **Object Storage & Archive Storage** » crie um *Bucket* de nome único » **Create Pre-Authenticated Request** » **Permit object reads and writes** e copie a URL fornecida.

No arquivo `main.tf` descomente as linhas de 9 a 12 e insira a URL fornecida no campo `address`. Este é um passo meramente opcional.

2. Adicione algumas variáveis ao seu arquivo `.bashrc` ou `.zshrc` preenchendo-as com os valores obtidos anteriormente:

```bash
export TF_VAR_tenancy_ocid=<suas credenciais>
export TF_VAR_user_ocid=<suas credenciais>
export TF_VAR_fingerprint=<suas credenciais>
export TF_VAR_private_key_path=~/.oci/oci_api_key.pem
export TF_VAR_public_key_path=$(cat /home/seu-usuário/.ssh/id_rsa.pub)
```

## Execução:

1. Clone este repo.
2. Por padrão será provisionada uma instância com o Ubuntu 22.04 com hardware AMD, caso deseje outro S.O ou uma máquina ARM, modifique os arquivos `variables.tf` e `main.tf` se desejar.
3. Rode os comandos `terraform init`, `terraform plan -out= nome-do-plano` e `terraform apply`. Por fim, `terraform destroy` para exclusão do que foi criado na OCI.