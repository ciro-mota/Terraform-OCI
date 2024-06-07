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
  type        = string
  default     = "Terraform-OCI-Always-Free"
  description = "Specifies a name for the Compartment that will be used."
}

variable "instance_name" {
  type        = string
  default     = "Always_Free"
  description = "Rename the instance name as you like."
}

variable "hostname_label" {
  type        = string
  default     = "Always-Free"
  description = "Rename the instance label as you like."
}

variable "shape_arm" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "shape_arm_cpus" {
  type        = number
  default     = 4
  description = "Allowed from 1 to 4 OCPU's on Always Free."
}

variable "shape_arm_memory" {
  type        = number
  default     = 8
  description = "Allowed from 1 to 24GB in Always Free."
}

variable "count_instance" {
  default     = 1
  description = "Defines the number of instances that will be provisioned. Two AMD limit on Always Free."
}