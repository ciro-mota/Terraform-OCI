output "public-ip-for-compute-instance" {
  value = oci_core_instance.alwaysfree.public_ip
}