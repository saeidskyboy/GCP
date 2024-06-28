# action required: 1- create a service account and attach a key (create a .json format key into it) for athentication 2- create a file with name keys.json
# paste the created key into it (it is addressed in provider file)

resource "google_storage_bucket" "test5" { # test5 here id our resource name in terraform which i.e. we can refer to it or manage it in terraform 
  name                     = "any-name-that-you-would-like-to-take"
  location                 = "us-central1"
  force_destroy            = true
  public_access_prevention = "enforced"

  storage_class = "NEARLINE" # depend on our needs we can choose different type of bucket class

  uniform_bucket_level_access = true # by enabling it, it will remove older ACLs ststem and relying solely on IAM permissions. which can help improve security

  # this rule will delete objects older than X days, refer to: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
  # to find more rules/actions
  lifecycle_rule {
    condition {
      age = 45 # it is in days
    }
    action {
      type = "Delete" #test.
    }
  }

  labels = {
    "gcp"       = "my-cloud-storage"
    "terraform" = "object"
  }
}

resource "google_storage_bucket" "test6" { # test6 here id our resource name in terraform which i.e. we can refer to it or manage it in terraform 
  name                     = "any-name-that-you-would-like-to-take-2"
  location                 = "us-central1"
  force_destroy            = true
  public_access_prevention = "enforced"

  storage_class = "STANDARD" # depend on our needs we can choose different type of bucket class

  uniform_bucket_level_access = true # by enabling it, it will remove older ACLs ststem and relying solely on IAM permissions. which can help improve security

  # this rule will delete objects which are not succesfully/completly uploaded after X days, refer to: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
  # to find more rules/actions
  lifecycle_rule {
    condition {
      age = 10 # it is in days
    }
    action {
      type = "Delete"
    }
  }

  labels = {
    "gcp"       = "second-cloud-storage"
    "terraform" = "object2"
  }
}
