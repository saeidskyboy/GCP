resource "google_compute_network" "vpc" {
    name = var.vpc_name
    cidr_range = var.cidr_range
    instance_tenancy = var.instance_tenancy
}