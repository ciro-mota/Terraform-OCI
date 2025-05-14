terraform {
  required_version = "1.9.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.0.0"
    }
  }
  # backend "http" {
  #   update_method = "PUT"
  #   address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/<my-access-url>/o/terraform/terraform.tfstate"
  # }
}

module "Ampere" {
  source           = "./modules/ampere"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  fingerprint      = var.fingerprint
}