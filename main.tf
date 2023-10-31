terraform {
  required_version = ">= 1.6.2"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.18.0"
    }
  }
  # backend "http" {
  #   address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/<my-access-uri>"
  #   update_method = "PUT"
  # }
}