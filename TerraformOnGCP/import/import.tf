import {
  id = "projects/cloud-2255/zones/us-central1-c/instances/vm45"
  to = google_compute_instance.vm1
}


import {
  id = "projects/cloud-2255/zones/us-central1-c/instances/vm55"
  to = google_compute_instance.vm2
}


import {
  id = "projects/cloud-2255/global/networks/vpc"
  to = google_compute_network.my-network
}
