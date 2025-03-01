# #here is the backend.tf file configs for terraform, if you are willing store your state file in a bucket uncomment bellow codes and add your bucket name and prefix.

terraform {
  backend "gcs" {
    bucket = "store-saeid-gke-statefiles-simu"
    prefix = "gke/terraform.tfstate"
    # credentials = env("GOOGLE_APPLICATION_CREDENTIALS")
  }
}