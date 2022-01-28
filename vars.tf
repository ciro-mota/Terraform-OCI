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

variable "images" {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaanso5stfs7ncicgvkrnwuwqwnmzatv7mv2flbdfyeb2dlh43pprta"
}