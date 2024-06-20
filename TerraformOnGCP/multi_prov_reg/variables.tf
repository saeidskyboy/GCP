variable "London" {
  type        = string
  description = "london region"
  #    default = "europe-west2"  
}

variable "Dallas" {
  type        = string
  description = "Dallas region"
  #    default = "us-south1"  
}

variable "cidr_block" {
  type        = string
  description = "cidr block"
  #    default = "10.0.0.0/16"  
}

variable "machine_type" {
  description = "value of machine_type"
}

variable "image" {
  description = "value of image"
}

variable "google_compute_network" {
  type        = string
  description = "a name for our vpc"
  #  default = "my-vpc"
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "value of auto_create_subnetworks"
  #  default = false
}

variable "sub1_cidr_range" {
  type        = string
  description = "value of sub1_cidr_range"
  #   default = "10.0.0.0/24"  
}

variable "sub2_cidr_range" {
  type        = string
  description = "value of sub2_cidr_range"
  #    default = "10.0.1.0/24"  
}

variable "credentials" {
    type = string
  description = "value of credentials"
}

variable "project-id" {
    type = string
    description = "value of project-id"  
}