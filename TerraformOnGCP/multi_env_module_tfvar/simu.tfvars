vpc_name         = "custome-vpc-simulation"
subnet_names     = ["subnet-test1", "subnet-t2", "subnet-h1", "subnet-b7"]
subnet_ip_ranges = ["10.0.8.0/24", "10.0.9.0/24", "10.0.12.0/24", "10.0.32.0/24"]
subnet_region    = "us-central1"

instance_names = ["stage-vm-t7", "simu-vm-t7", "dev-vm-c7"]
zones          = ["us-central1-b", "us-central1-c", "us-central1-f"]
machine_type   = "e2-micro"
image          = "debian-cloud/debian-11" # what image you would like to use to boot your vms