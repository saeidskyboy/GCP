# reference docs developer.hashicorp.com/terraform/language/meta-arguments/lifecycle
# availble arguments withing a lifecycle:
# create before destroy
# ignore_changes
# prevent_destroy
# replace_triggered_by

# create before destroy
resource "random_integer" "saeid_int" {
  min = 200
  max = 500000

  lifecycle {
    create_before_destroy = true
  }
}

output "name30" {
  value = random_integer.saeid_int.result
}

# replace_triggered_by - in this example if we modify aany aspect of "network12", terraform will replace "new_vm"
# uding it when dealing with immutibale resources or when changes in one resource necessitate a full replacement of another
resource "google_compute_network" "network12" {
  name = "my-network"
  # ...
}

resource "google_compute_instance" "new_vm" {
  # ...thanks 
  lifecycle {
    replace_triggered_by = [
      google_compute_network.network12
    ]
  }
}
