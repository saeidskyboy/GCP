vpc_name = "custome-vpc-simu"
subnet_names = ["subnet-test1", "subnet-t2", "subnet-c1", "subnet-c7"]
subnet_ip_ranges = ["10.0.1.0/25", "10.0.0.1/25", "10.5.0.1/24"]
subnet_region = "us-central1"

instance_names = ["dev-vm-t7", "simu-vm-t7", "prod-vm-c7"]
zones = ["us-central1-b", "us-central1-c", "us-central1-f"]
machine_type = "e2-micro"
image = "debian-cloud/debian-12"