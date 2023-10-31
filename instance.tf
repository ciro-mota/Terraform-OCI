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
  shape               = var.shape_amd

  create_vnic_details {
    subnet_id        = oci_core_subnet.test_subnet.id
    display_name     = "primaryVnic"
    assign_public_ip = true
    hostname_label   = var.hostname_label
  }

  source_details {
    source_type = "image"
    # source_id   = data.oci_core_images.ubuntu22.images.0.id
    # source_id = data.oci_core_images.ubuntu20.images.0.id # Comment above line and uncomment this one to use image from Ubuntu 20.04.
    source_id = data.oci_core_images.oraclelinux9.images.0.id # Comment above line and uncomment this one to use image from Oracle Linux 9.x.
    # source_id = data.oci_core_images.oraclelinux8.images.0.id # Comment above line and uncomment this one to use image from Oracle Linux 8.x.
  }

  metadata = {
    ssh_authorized_keys = var.public_key_path
    # user_data           = "${base64encode(file("./scripts/script.sh"))}" # Uncomment this line to use an instance deployment script. View and adapt the contents of the attached script.sh file.
  }

}