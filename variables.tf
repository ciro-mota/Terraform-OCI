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

variable "compartment_ocid" {
  sensitive = true
}

variable "region" {
}

variable "instance_name" {
  type    = string
  default = "Always_Free" # Mude o nome da instância à seu gosto.
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
  type    = string
  default = "4" # Permitido de 1 até 4 OCPU's no Always Free.
}

variable "shape_arm_memory" {
  type    = string
  default = "8" # Permitido de 1 até 24GB no Always Free.
}