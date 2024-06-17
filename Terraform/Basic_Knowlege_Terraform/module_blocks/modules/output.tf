# this module will use main.tf (in mudole folder) names then add "id" 
output "result" {
  value = random_integer.saeid_int.id
}

output "result2" {
  value = random_string.saeid_str.id
}