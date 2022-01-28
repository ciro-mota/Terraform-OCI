data "oci_identity_availability_domains" "ad" {
  compartment_id = var.tenancy_ocid
}