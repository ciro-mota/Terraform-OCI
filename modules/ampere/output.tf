output "public-ip-for-compute-instance" {
  value = {
    for instance in oci_core_instance.instance :
    instance.display_name => instance.public_ip
  }
  sensitive = false
}