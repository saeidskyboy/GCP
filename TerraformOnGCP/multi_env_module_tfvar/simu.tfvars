vpc_name         = "custome-vpc-simu"
subnet_names     = ["subnet-test1-simu", "subnet-t2-simu", "subnet-h1-simu", "subnet-b7-simu"]
subnet_ip_ranges = ["10.0.8.0/24", "10.0.9.0/24", "10.0.12.0/24", "10.0.32.0/24"]
subnet_region    = "us-central1"

instance_names = ["simu-vm-b7", "simu-vm-t7", "simu-vm-c7"]
zones          = ["us-central1-b", "us-central1-c", "us-central1-f"]
machine_type   = "e2-micro"
image          = "debian-cloud/debian-11" # what image you would like to use to boot your VMs