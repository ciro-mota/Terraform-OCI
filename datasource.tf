data "oci_core_images" "ubuntu20" {
  compartment_id   = local.compartment_id
  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"

  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-20.04-([\\.0-9-]+)$"]
    regex  = true
  }
}

data "oci_core_images" "ubuntu22" {
  compartment_id   = local.compartment_id
  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"

  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-22.04-([\\.0-9-]+)$"]
    regex  = true
  }
}

data "oci_core_images" "ubuntu_aarch64" {
  compartment_id   = local.compartment_id
  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"

  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-20.04-aarch64-([\\.0-9-]+)$"]
    regex  = true
  }
}

data "oci_core_images" "oraclelinux" {
  compartment_id   = local.compartment_id
  operating_system = "Oracle Linux"
  sort_by          = "TIMECREATED"

  filter {
    name   = "display_name"
    values = ["^Oracle-Linux-8([\\.0-9\\-\\0-9\\.]+)$"]
    regex  = true
  }
}

data "oci_core_images" "centos_7" {
  compartment_id           = local.compartment_id
  operating_system         = "CentOS"
  operating_system_version = "7"
  sort_by                  = "TIMECREATED"
}

data "oci_identity_availability_domains" "ADs" {
  compartment_id = local.compartment_id
}

data "oci_identity_regions" "regions" {}