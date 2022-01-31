terraform {
  required_version = ">= 0.12.6"
  required_providers {
    oci = {
      version = ">= 4.0.0"
    }
  }
  # backend "http" {
  #   address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/<my-access-uri>"
  #   update_method = "PUT"
  # }
}