vpc_name         = "custome-vpc-dev"
subnet_names     = ["subnet-test1", "subnet-t2", "subnet-c1", "subnet-c7"]
subnet_ip_ranges = ["10.0.7.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
subnet_region    = "us-central1"

instance_names = ["dev-vm-f7", "dev-vm-t7", "dev-vm-c7"]
zones          = ["us-central1-b", "us-central1-c", "us-central1-f"]
machine_type   = "e2-micro"
image          = "debian-cloud/debian-11" # what image you would like to use to boot your vms