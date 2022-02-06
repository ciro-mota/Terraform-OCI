data "oci_core_vnic_attachments" "app_vnics" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[0].name
  instance_id         = oci_core_instance.instance[0].id
}
data "oci_core_vnic" "app_vnic" {
  vnic_id = data.oci_core_vnic_attachments.app_vnics.vnic_attachments[0]["vnic_id"]
}
resource "oci_core_virtual_network" "test_vcn" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "testeVCN"
  dns_label      = "testevcn"
}
resource "oci_core_subnet" "test_subnet" {
  cidr_block        = "10.1.20.0/24"
  display_name      = "testeSubnet"
  dns_label         = "testesubnet"
  security_list_ids = [oci_core_security_list.test_security_list.id]
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.test_vcn.id
  route_table_id    = oci_core_route_table.test_route_table.id
  dhcp_options_id   = oci_core_virtual_network.test_vcn.default_dhcp_options_id
}
resource "oci_core_internet_gateway" "test_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "testeIG"
  vcn_id         = oci_core_virtual_network.test_vcn.id
}
resource "oci_core_route_table" "test_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.test_vcn.id
  display_name   = "testeRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.test_internet_gateway.id
  }
}
resource "oci_core_security_list" "test_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.test_vcn.id
  display_name   = "testeSecurityList"

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = "22"
      min = "22"
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = "80"
      min = "80"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
}