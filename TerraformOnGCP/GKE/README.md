1- after terraform apply succeed (all resources created)
2- if you wanna connect to the cluster via your local laptop, run: gcloud container clusters get-credentials <cluster name> --zone <cluster's zone> --project <project ID>
3- if you have gcloud and kubectl install on your local machine you have to be able interact with your cluster (kubectl get pods/kubectl get svc etc)
4- deploy file k8s-config/deployment.yml -> kubectl apply -f k8s-config/deployment.yml
5- kubectl get pods -w
6- using workload identity and granting access to the pod to list GC buckets:
    - uncomment file service-account.tf and run terraform apply again to create a service account and grant access to GC bucket
    check to have "Cloud Resource Manager API" enaled (for GH action interaction)
7- once the service account created deploy file namespace.tf
our pod can interact with our bucket, go to the pod ->
    - kubectl get pods -n staging
    - copy pod name
    - kubectl exec -n staging -it gcloud-f44f7dfd8-8m7fb -- /bin/bash
    - gcloud alpha storage ls (we have to see our created bucket here)
-8 have "helm" install on your system -> macos = brew install helm
9- install ingress-nginx: the helm resource for more details and read: https://kubernetes.github.io/ingress-nginx/deploy/
in the cli -> helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
10- helm repo update, then by running -> "helm search repo nginx" we have to be able see the ingress nginx details
11- uncomment file nginx-values and run below commands to deploy our ingress:
helm install my-ing ingress-nginx/ingress-nginx --namespace ingress-nginx --version 4.12.0 --values k8s-configs/nginx-values.yml --create-namespace
in case you will see -> "Error: INSTALLATION FAILED: Unable to continue with install: IngressClass "nginx" in namespace "" exists and cannot be imported... --- then delete the current namespace and use --replace flag in the end ->
    - kubectl delete ingressclass nginx
    - helm install my-ing ingress-nginx/ingress-nginx --namespace ingress --version 4.12.0 --values k8s-configs/nginx-values.yml --create-namespace --replace
12- You can watch the status by running 'kubectl get service --namespace ingress my-ing-ingress-nginx-controller --output wide --watch'
13- kubectl apply -f k8s-configs/service.yml
14- kubectl get ing (we have to have result with nginx-ing)

15- ahve ansible installedCID

*** When you assign the Kubernetes Engine Cluster Admin role to a service account, it grants the service account permissions to manage Kubernetes Engine clusters, but it does not grant the exact same permissions as the roles/container.clusterAdmin role.