locals {
  compartment_id = oci_identity_compartment.compartment-name.id
  enable_delete  = true
}

locals {
  region_map = { for r in data.oci_identity_regions.regions.regions : r.key => r.name }
}