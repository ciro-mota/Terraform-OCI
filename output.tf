output "public-ip-for-compute-instance" {
  value = oci_core_instance.instance[0].public_ip
}