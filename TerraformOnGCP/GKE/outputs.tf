# this output will pass info to make sure that indicates the cluster's existence
# so we we don't need rerun this workflow in GH 
output "cluster_name" {
  value = element(concat(google_container_cluster.gke-cluster.*.name, [""]), 0)
}

output "cluster_region" {
  value = element(concat(google_container_cluster.gke-cluster.*.location, [""]), 0)
}