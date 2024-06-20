# reference docs: https://developer.hashicorp.com/terraform/language/modules
# a mudole that has been called by another module is offen rederred to as a child module
# module blockes are documents the syntax for calling a child module from a parent module, including meta-arguments like create_before_destroy/depends_on/for_each ...
# a module is a container for multiple resources that are ised together
# after adding/removing/modifying "module blocks", we must re-run "terraform init" to allow terraform to pick up the changes

terraform {
    required_version = ">= 1.0.0"
}
# based on the defined variables in previous step, address the resource by the sat names in variable.tf, then will go to output.tf
resource "random_string" "saeid_str" {
    length = var.id_length
}

resource "random_integer" "saeid_int" {
  min = var.min_int
  max = var.max_int
}