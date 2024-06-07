<h2>Terraform-OCI</h2>

<p align="center">
    <img alt="License" src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge" />
    <img alt="Oracle" src="https://img.shields.io/badge/Oracle-F80000?logo=oracle&logoColor=fff&style=for-the-badge" />
    <img alt="Terraform" src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" />
    <img alt="OpenTofu" src="https://img.shields.io/badge/OpenTofu-FFDA18?logo=opentofu&logoColor=000&style=for-the-badge" />
    <img alt="Ansible" src="https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white" />
    <img alt="AlmaLinux" src="https://img.shields.io/badge/AlmaLinux-000?logo=almalinux&logoColor=fff&style=for-the-badge" />
    <img alt="Oracle Linux" src="https://img.shields.io/badge/Oracle_Linux-fff?logo=oracle&logoColor=F80000&style=for-the-badge" />
    <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" />
    <img alt="Shell Script" src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white" />
</p>

Provision an instance ARM on Oracle OCI with **_Always Free_** features and standard machine type.

> [!IMPORTANT]\
> Be aware of what is included in Always Free mode. \
> https://www.oracle.com/cloud/free/#free-cloud-trial

## 📋 Requirements:

* Terraform or OpenTofu.

* Proceed with [OCI-CLI installation as per official documentation](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm).

## 📌 Before executing:

> [!NOTE]\
> It is necessary to get credentials for Terraform execution.

1. These values are taken directly from the OCI Cloud Console:

- **tenancy_ocid**:

Login into your OCI Cloud Console account and then go to [this address](https://cloud.oracle.com/tenancy). In **OCID** click on **Copy** or **Show**, copy and paste into a notepad.

<details>
  <summary>Clique to show example</summary>
</br>

![](/images/tenancy.png)
</details>


- **user_ocid**:

**Main Menu** » **Domains** » **OracleIdentityCloudService (Current domain)** » **Users**. Click on your user. In **OCID** click on **Copy** or **Show**, copy and paste into a notepad.

- Run the commands below to generate a key pair required for authentication:

```bash
mkdir ~/.oci
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
chmod go-rwx ~/.oci/oci_api_key.pem
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
```

- **fingerprint**:

Capture the `public_key` generated in the previous step (`cat ~/.oci/oci_api_key_public.pem`) » access **Main Menu** » **Domains** » **OracleIdentityCloudService (Current domain)** » **Users** » **<<your-email\>>** » **API Keys** » **Add API Key** » **Paste Public Key** and paste the public key content.

This will generate your **fingerprint** And access information that you will need to add to the file `~/.oci/config`.

- **SSH**:

A key pair may be required for SSH access to the instance. If not, generate a new pair with the command `ssh-keygen -b 2048 -t rsa`.

2. Add some variables to your `.bashrc` or `.zshrc` file by filling them in with the values obtained earlier:

```bash
export TF_VAR_tenancy_ocid=<your credencials>
export TF_VAR_user_ocid=<your credencials>
export TF_VAR_fingerprint=<your credencials>
export TF_VAR_private_key_path=~/.oci/oci_api_key.pem
export TF_VAR_public_key_path=$(cat /home/your-username/.ssh/<your-pub-key>.pub)
```

## 💻 Usage

> [!NOTE]\ 
> You will be able to choose between Ubuntu 20.04 or 22.04 or Oracle Linux or AlmaLinux (Marketplace) images.

1. Clone this repo.
2. By default an instance with **Ubuntu 22.04** with ARM hardware will be provisioned, if you want another OS modify the `instance.tf` file on lines `28` and `29`, if you wish.
3. Run `terraform init`, `terraform plan -out= name-of-the-plan` and `terraform apply`. At the end, `terraform destroy` for deletion of what was created in the OCI.

## 💾 Remote state

You might want to store your *states* remotely in an OCI bucket. For this **Main Menu** » **Storage** » **Object Storage & Archive Storage** » create a uniquely named *Bucket* » **Create Pre-Authenticated Request** » **Permit object reads and writes**, and copy the given URL.

In the `main.tf` file, uncomment lines `9` to `12` and insert the given URL in the `address` field. This is a purely optional step.

## 🔧 Post Install Scripts

You can also apply post-installation scripts to your instance through. This project counts as example scripts for `nginx` provisioning provided by Ansible Galaxy.

To work with these settings, uncomment line `34` in the `instance.tf` file.

## 🎁 Sponsoring

If you like this work, give me it a star on GitHub, and consider supporting it buying me a coffee:

[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.com/donate/?business=VUS6R8TX53NTS&no_recurring=0&currency_code=USD)