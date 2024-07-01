# random_integer is a resource not a name
# Link to docs: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer
resource "random_integer" "s_random" {
    min = 200
    max = 500000
}

resource "random_string" "s_random" {
    length = 16
    special = false
    upper = false
}

resource "random_shuffle" "s_random" {
    input = ["us-west1-b", "us-centeral1-f", "us-east1-b", "us-west1-a"]
    result_count = 2
}

# result a name
output "saeid_num" {
    # result is not a name but a logical function (cloud be somethhing else )
  value = random_integer.s_random.result
}

output "saeid_alpha" {
  value = random_string.s_random.result
}

output "saeid_region" {
  value = random_shuffle.s_random.result
}