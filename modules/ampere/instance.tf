resource "oci_identity_compartment" "compartment-name" {
  name          = var.compartment_name
  description   = var.compartment_name
  enable_delete = true
}

resource "oci_core_instance" "instance" {
  availability_domain = data.oci_identity_availability_domains.ADs.availability_domains[0].name
  compartment_id      = local.compartment_id
  count               = var.count_instance
  display_name        = "${var.instance_name}-${count.index}"
  shape               = var.shape_arm

  shape_config {
    ocpus         = var.shape_arm_cpus
    memory_in_gbs = var.shape_arm_memory
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.test_subnet.id
    display_name     = "primaryVnic"
    assign_public_ip = true
    hostname_label   = var.hostname_label
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu24_aarch64.images.0.id
    #source_id   = data.oci_core_images.ubuntu22_aarch64.images.0.id  Comment line above and uncomment this one to use Ubuntu 22.04 aarch64 image.
    #source_id = data.oci_core_images.ubuntu20_aarch64.images.0.id # This one to use Ubuntu 20.04 aarch64 image.
    #source_id   = data.oci_core_images.oraclelinux9_aarch64.images.0.id # This to use Oracle Linux aarch64 image.
    #source_id = lookup(data.oci_core_app_catalog_listing_resource_version.AlmaLinux_App_Catalog_Listing_Resource_Version, "listing_resource_id") # This to use AlmaLinux aarch64 Marketplace image.
  }

  metadata = {
    ssh_authorized_keys = var.public_key_path
    # user_data           = "${base64encode(file("${path.root}/scripts/script.sh"))}" # Uncomment this line to use an instance deployment script.
  }

}
