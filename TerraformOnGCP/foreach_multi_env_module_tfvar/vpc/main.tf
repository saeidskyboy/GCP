# resource "google_compute_network" "vpc_network" {
#   name                    = var.vpc_name
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "vpc_subnetwork" {
#   count         = length(var.subnet_ip_ranges)
#   name          = var.subnet_names[count.index]
#   region        = var.subnet_region
#   network       = google_compute_network.vpc_network.id
#   ip_cidr_range = var.subnet_ip_ranges[count.index]
# }

# output "subnet_ids" {
#   value =  [for s in google_compute_subnetwork.vpc_subnetwork : s.id] # if you see warning in this line, you can ignore it and run the code, it is due to using "asterisk" which 
#   # VS Code might not fully understand the expression due to its dynamic nature, Terraform itself will correctly interpret the splat expression during execution.
#   description = "list of subnet ids"
  
# }