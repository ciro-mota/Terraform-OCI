terraform {
  required_version = "1.7.2"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.41.0"
    }
  }
  # backend "http" {
  #   address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/<my-access-uri>"
  #   update_method = "PUT"
  # }
}