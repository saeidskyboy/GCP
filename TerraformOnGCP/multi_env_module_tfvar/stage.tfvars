vpc_name         = "custome-vpc-stage"
subnet_names     = ["subnet-test1-stage", "subnet-t2-stage", "subnet-c1-tage", "subnet-c7-stage"]
subnet_ip_ranges = ["10.0.8.0/24", "10.0.9.0/24", "10.0.12.0/24", "10.0.32.0/24"]
subnet_region    = "us-central1"

instance_names = ["stage-vm-f7", "stage-vm-t7", "stage-vm-c7"]
zones          = ["us-central1-b", "us-central1-c", "us-central1-f"]
machine_type   = "e2-micro"
image          = "debian-cloud/debian-11" # what image you would like to use to boot your VMs