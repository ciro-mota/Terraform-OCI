resource "oci_identity_compartment" "compartment-name" {
  name          = var.compartment_name
  description   = var.compartment_name
  enable_delete = true
}

resource "oci_core_instance" "instance" {
  availability_domain = data.oci_identity_availability_domains.ADs.availability_domains[0].name
  compartment_id      = local.compartment_id
  count               = var.count_instance
  display_name        = var.instance_name
  shape               = var.shape_amd
  #  shape               = var.shape_arm # To use with ARM shape. See variable.tf file to configue CPU and MEM sizes.

  # shape_config {                            #
  #    ocpus         = var.shape_arm_cpus    # Uncomment this block code to use with ARM shape.
  #    memory_in_gbs = var.shape_arm_memory #
  #  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.test_subnet.id
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "Instance-Always-Free"
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu22.images.0.id
    # source_id = data.oci_core_images.ubuntu20.images.0.id # Comment above line and uncomment this one to use image from Ubuntu 20.04.
    # source_id = data.oci_core_images.ubuntu22_aarch64.images.0.id # Comment above line and uncomment this one to use image from Ubuntu 22.04 aarch64.
    # source_id = data.oci_core_images.ubuntu20_aarch64.images.0.id # Comment above line and uncomment this one to use image from Ubuntu 20.04 aarch64.
    # source_id   = data.oci_core_images.oraclelinux8.images.0.id # Comment above line and uncomment this one to use image from Oracle Linux 8.x.
    # source_id   = data.oci_core_images.oraclelinux9.images.0.id # Comment above line and uncomment this one to use image from Oracle Linux 9.x.
  }

  metadata = {
    ssh_authorized_keys = var.public_key_path
    # user_data           = "${base64encode(file("script.sh"))}" # Uncomment this line to use an instance deployment script. View and adapt the contents of the attached script.sh file.
  }

}