# filename =var.(f2/inpute_zone) is name of our file which we sat in variable.tf front of "variables"
resource "local_file" "s_resource" {
  filename        = var.f2
  content         = var.cont
  file_permission = var.file_perm
}

resource "random_shuffle" "shuffle_saeid" {
  input        = var.inpute_zones
  result_count = 1
}

resource "local_file" "s_resource2" {
  filename = var.f2               # this is where we want to return the value which is file "terraform.txt"
  content  = var.map_saeid["age"] # it is referring what should be returnedtzx
}

output "result_zones_output" {
  value = random_shuffle.shuffle_saeid.result
}

# Implicit dependencies - when one resource properties are used in another resource's property or output. terraform use these references to automatically
#determine the order of resource creation.

resource "random_integer" "s52_test" {
  min = 200
  max = 500000
}
resource "local_file" "s_resource3" {
  filename = "test_implicit_dependency.txt"
  content  = "here we can refer to our random integer, which will return the value here: ${random_integer.s52_test.id}" # we have to specify "id"
}

# Explicit dependency - should only defin when terraform cannot automaticalyy infer the required order of resource creation. or when specific provisiong 
# steps are necessary before or after a resource is deployed.

resource "random_string" "sr256" {
  length = 23
}

resource "local_file" "loc254" {
  filename = "test_explicit_dependency.txt"
  content  = "here the result will read above bloc kwhich is random string and we set a dependency on it in below, which the result will be:: ${random_string.sr256.result}"
  depends_on = [
    random_string.sr256
  ]
}
