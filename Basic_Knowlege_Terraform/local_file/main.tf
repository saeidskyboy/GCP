resource "local_file" "test" {
  filename = "example.txt"
  content = "let's try new things with Terraform"
  file_permission = "0777"
}