variable "tenancy_ocid" {
  sensitive = true
}

variable "user_ocid" {
  sensitive = true
}

variable "fingerprint" {
  sensitive = true
}

variable "private_key_path" {
  sensitive = true
}

variable "public_key_path" {
  sensitive = true
}

variable "compartment_name" {
  type    = string
  default = "Terraform-OCI-Always-Free" # Specifies a name for the Compartment that will be used.
}

variable "instance_name" {
  type    = string
  default = "Always_Free" # Rename the instance name as you like.
}

variable "shape_amd" {
  type    = string
  default = "VM.Standard.E2.1.Micro"
}

variable "shape_arm" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "shape_arm_cpus" {
  type    = number
  default = 8 # Allowed from 1 to 4 OCPU's on Always Free.
}

variable "shape_arm_memory" {
  type    = number
  default = 8 # Allowed from 1 to 24GB in Always Free.
}

variable "count_instance" {
  default = 1 # Defines the number of instances that will be provisioned. Two AMD limit on Always Free.
}