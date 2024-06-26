variable "f2" {
  type    = string
  default = "terraform.txt"
}

variable "cont" {
  type    = string
  default = "what about skyboy experience?"
}

variable "file_perm" {
  type    = string
  default = "0777"
}

variable "inpute_zones" {
  type    = list(any)
  default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}

variable "map_saeid" {
  type = map(any)
  default = {
    name = "saeid"
    age  = 30
    city = "Prague"
  }
}


# type of variables
# string
# number
# bool
# list
# map = it is like a dictionary 
# tuple = it is a list of different types of variables (combination of i.e. string/number/bool)
# object
# set
