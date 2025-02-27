
<<<<<<< HEAD:TerraformOnGCP/multi_env_module_tfvar/backend.tf
# #here is the backend.tf file configs for terraform, if you are willing store your state file in a bucket uncomment bellow codes and add your bucket name and prefix.

# terraform {
#   backend "gcs" {
#     bucket = "mybucket-state-backup"
#     prefix = "multi_env_statefiles"
#     #state_lock = true # by enabling it we can prevent the race conditions (terraform will try to aquire a lock before creating/modifying a state file, and if another process is creating/modifying a state file, it will wait until it is done)
#     credentials = "./keys.json"
#   }
=======
#here is the backend.tf file configs for terraform, if you are willing store your state file in a bucket uncomment bellow codes and add your bucket name and prefix.
# resource: https://developer.hashicorp.com/terraform/language/backend/gcs
# terraform {
#     backend "gcs" {
#         bucket = "name of our bucket which the state will be stored"
#         prefix = "if you would like to store the state in a different folder, specify it here + /<dev/prod/simu/terraforn>.tfstate"
#     }
>>>>>>> workflow:backend.tf
# }
