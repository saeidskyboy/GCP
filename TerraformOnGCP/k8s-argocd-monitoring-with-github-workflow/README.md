1- after terraform apply succeed (all resources created)
2- if you wanna connect to the cluster via your local laptop, run: gcloud container clusters get-credentials <cluster name> --zone <cluster's zone> --project <project ID>
3- if you have gcloud and kubectl install on your local machine you have to be able interact with your cluster (kubectl get pods/kubectl get svc etc)
    check to have "Cloud Resource Manager API" enaled (for GH action interaction)
our pod can interact with our bucket, go to the pod ->
    - kubectl get pods -n staging
    - copy pod name
    - kubectl exec -n staging -it gcloud-f44f7dfd8-8m7fb -- /bin/bash
    - gcloud alpha storage ls (we have to see our created bucket here)
4- since this configs are using remote repo we need to create bucket and pass its path inot provider.tf file
5- action required in github repo:
    - in our repo, setting/secrete and variables/actions create a file and name it "GCP_SA_KEY" pass our service account key value (in cloud we need to create a key file which will be attached to the service account) and github will use this key to for authentication
    - create another file into actions and name it "GCP_PROJECT_ID", write your cloud project ID here

12- You can watch the status by running 'kubectl get service --namespace ingress my-ing-ingress-nginx-controller --output wide --watch'

*** When you assign the Kubernetes Engine Cluster Admin role to a service account, it grants the service account permissions to manage Kubernetes Engine clusters, but it does not grant the exact same permissions as the roles/container.clusterAdmin role.

16- for this project I had these roles granted to my service account (some of them were for diff projects so not necessarly all of them are require): 	
Compute Instance Admin (v1)
Compute Network Admin
Compute Security Admin
Kubernetes Engine Admin
Kubernetes Engine Developer
Project IAM Admin
Role Viewer
Service Account Key Admin
Service Account User
Storage Admin
Workload Identity User