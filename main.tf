terraform {
  required_version = ">= 1.0.11"
  required_providers {
    oci = {
      version = ">= 4.62.0"
    }
  }
  # backend "http" {
  #   address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/<my-access-uri>"
  #   update_method = "PUT"
  # }
}