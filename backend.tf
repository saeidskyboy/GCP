
#here is the backend.tf file configs for terraform, if you are willing store your state file in a bucket uncomment bellow codes and add your bucket name and prefix.
# resource: https://developer.hashicorp.com/terraform/language/backend/gcs
# terraform {
#     backend "gcs" {
#         bucket = "name of our bucket which the state will be stored"
#         prefix = "if you would like to store the state in a different folder, specify it here + /<dev/prod/simu/terraforn>.tfstate"
#     }
# }
