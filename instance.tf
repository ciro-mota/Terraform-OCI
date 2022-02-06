data "oci_core_images" "ubuntu" {
  compartment_id   = var.compartment_ocid
  operating_system = "Canonical Ubuntu"
  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-20.04-([\\.0-9-]+)$"]
    regex  = true
  }
}
data "oci_core_images" "ubuntu_aarch64" {
  compartment_id   = var.compartment_ocid
  operating_system = "Canonical Ubuntu"
  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-20.04-aarch64-([\\.0-9-]+)$"]
    regex  = true
  }
}
data "oci_core_images" "oraclelinux" {
  compartment_id   = var.compartment_ocid
  operating_system = "Oracle Linux"

  filter {
    name   = "display_name"
    values = ["^Oracle-Linux-8.5-([\\.0-9-]+)$"]
    regex  = true
  }
}
data "oci_core_images" "centos_7" {
  compartment_id           = var.compartment_ocid
  operating_system         = "CentOS"
  operating_system_version = "7"
  sort_by                  = "TIMECREATED"
}

resource "oci_core_instance" "instance" {
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  count               = var.count_instance
  display_name        = var.instance_name
  shape               = var.shape_amd
  # shape               = var.shape_arm # Comente a entrada acima e descomente esta para usar o shape ARM. Configue no arquivo de variáveis o tamanho de CPU e MEM.

  # shape_config {                         #
  #   ocpus         = var.shape_arm_cpus   # Descomente este bloco ao usar o shape ARM.
  #   memory_in_gbs = var.shape_arm_memory #
  # }
  create_vnic_details {
    subnet_id        = oci_core_subnet.test_subnet.id
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "Instance-Always-Free"
  }
  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images.0.id
    # source_id = data.oci_core_images.ubuntu_aarch64.images.0.id # Comente a entrada acima e descomente esta para usar a imagem do Ubuntu aarch64.
    # source_id   = data.oci_core_images.oraclelinux.images.0.id # Comente a entrada acima e descomente esta para usar a imagem do Oracle Linux 8.5.
    # source_id   = data.oci_core_images.centos_7.images.0.id # Comente a entrada acima e descomente esta para usar a imagem do CentOS 7.
  }
  metadata = {
    ssh_authorized_keys = var.public_key_path
    # user_data           = "${base64encode(file("script.sh"))}" # Descomente esta entrada para usar um script de implantação da instância.
  }

}