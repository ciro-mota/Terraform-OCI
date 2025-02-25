data "oci_core_images" "ubuntu20_aarch64" {
  compartment_id   = local.compartment_id
  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"

  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-20.04-aarch64-([\\.0-9-]+)$"]
    regex  = true
  }
}

data "oci_core_images" "ubuntu22_aarch64" {
  compartment_id   = local.compartment_id
  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"

  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-22.04-aarch64-([\\.0-9-]+)$"]
    regex  = true
  }
}

data "oci_core_images" "ubuntu24_aarch64" {
  compartment_id   = local.compartment_id
  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"

  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-24.04-aarch64-([\\.0-9-]+)$"]
    regex  = true
  }
}

data "oci_core_images" "oraclelinux9_aarch64" {
  compartment_id   = local.compartment_id
  operating_system = "Oracle Linux"
  sort_by          = "TIMECREATED"

  filter {
    name   = "display_name"
    values = ["^Oracle-Linux-9\\.[0-9]+-aarch64-[0-9]{4}\\.[0-9]{2}\\.[0-9]{2}-0$"]
    regex  = true
  }
}

data "oci_identity_availability_domains" "ADs" {
  compartment_id = local.compartment_id
}

data "oci_identity_regions" "regions" {}