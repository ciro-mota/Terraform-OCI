resource "oci_core_instance" "alwaysfree" {
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "Ubuntu-Always-Free"
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = oci_core_subnet.test_subnet.id
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "Ubuntu-Always-Free"
  }

  source_details {
    source_type = "image"
    source_id   = var.images
  }

  metadata = {
    ssh_authorized_keys = var.public_key_path
  }
}