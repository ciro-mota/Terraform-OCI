output "public-ip-for-compute-instance" {
  value = oci_core_instance.instance.public_ip
}