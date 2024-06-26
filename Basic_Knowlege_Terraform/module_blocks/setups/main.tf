# by using names that we defined in variable.tf set the values in our module
module "saeid_module" {
    source = "../modules"
    id_length = 10
    min_int = 200
    max_int = 500000  
}

output "setup_output_int" {
  value = module.saeid_module.result
}

output "setup_output_ID" {
  value = module.saeid_module.result2
}
