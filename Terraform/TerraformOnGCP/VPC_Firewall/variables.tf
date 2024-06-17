variable "auto-vpc-tf" {
    type = string
    default = "auto-vpc-tf"
}

variable "cus-vpc-tf" {
  type = string
  default = "cus-vpc-tf"
}

variable "firewall-rules" {
    type = string
    default = "my-firewall-relues"
}

variable "sebnet-for-custome-vpc" {
  type = string
  default = "our-custome-vpc-subnet"
}

variable "ip-cidr-range-tf" {
    type = string
    default = "10.128.0.0/24"  
}

variable "regions-for-custom-vpc" {
    type    = string
  default = "us-central1"
}

variable "key-pair" {
  type = string
  default = "./keys.json"
}