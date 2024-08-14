terraform {
  required_version = "1.8.1"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.7.0"
    }
  }
  # backend "http" {
  #   address       = "https://objectstorage.us-ashburn-1.oraclecloud.com/<my-access-uri>"
  #   update_method = "PUT"
  # }
}