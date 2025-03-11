# Kubernetes (kubectl) and Google Cloud (gcloud) Cheat Sheet

This cheat sheet provides essential commands for interacting with Kubernetes clusters, particularly on Google Kubernetes Engine (GKE), and related Google Cloud resources.

**Table of Contents:**

*   [General Setup and Configuration](#general-setup-and-configuration)
*   [Cluster Information](#cluster-information)
*   [Working with Namespaces](#working-with-namespaces)
*   [Working with Deployments](#working-with-deployments)
*   [Working with Pods](#working-with-pods)
*   [Working with Services](#working-with-services)
*   [Working with Ingress](#working-with-ingress)
*   [Working with ConfigMaps and Secrets](#working-with-configmaps-and-secrets)
*   [Working with Helm](#working-with-helm)
*   [Argo CD Specific Commands](#argo-cd-specific-commands)
*   [Troubleshooting](#troubleshooting)
*   [Minikube (Local Kubernetes)](#minikube-local-kubernetes)
*   [GCloud Commands (Infrastructure)](#gcloud-commands-infrastructure)
*   [Ansible](#ansible)

## General Setup and Configuration

| Command                                   | Description                                                                                                                                                                                | Notes                                                                                                        |
| :---------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------- |
| `gcloud auth login`                       | Authenticates with Google Cloud using your user account. Use this for local development.                                                                                              | Run this *locally*, not in a workflow.                                                                   |
| `gcloud auth application-default login`   | Authenticates with Google Cloud using Application Default Credentials. Use this for local development when you want to use your user credentials for tools that support ADC.              | Run this *locally*.                                                                                       |
| `gcloud config set project <PROJECT_ID>` | Sets the default Google Cloud project.                                                                                                                                                    | Replace `<PROJECT_ID>` with your project ID.  You can also use `--project=<PROJECT_ID>` with most `gcloud` commands.|
| `gcloud container clusters get-credentials <CLUSTER_NAME> --zone <ZONE> --project <PROJECT_ID>` | Configures `kubectl` to connect to your GKE cluster.                                                                                                                 | Replace with your cluster name, zone, and project ID.                                                     |
| `kubectl config current-context`         | Shows the current `kubectl` context (which cluster you're connected to).                                                                                                        |                                                                                                              |
| `kubectl config get-contexts`           | Lists all available Kubernetes contexts.                                                                                                                                           | Use `kubectl config use-context <context-name>` to switch contexts.                                       |
| `kubectl config set-context --current --namespace=<NAMESPACE>` | Sets the default namespace for subsequent `kubectl` commands in the current context.                                                                   | Very useful to avoid repeatedly typing `-n <namespace>`.                                                         |
| `alias k=kubectl`                        | Creates a shorthand alias `k` for `kubectl`. (Optional, but convenient.  Add this to your `.bashrc` or `.zshrc` for persistence.)                                                  |                                                                                                              |
| `kubectl version`                          | Display the Kubernetes version.                                              |                           |

## Cluster Information

| Command                     | Description                                      | Notes                                                                       |
| :-------------------------- | :----------------------------------------------- | :-------------------------------------------------------------------------- |
| `kubectl cluster-info`      | Displays basic cluster information.              | Useful for a quick overview.                                               |
| `kubectl get nodes`         | Lists all nodes in the cluster.                   |                                                                             |
| `kubectl get nodes -o wide` | Lists nodes with more details (internal/external IP, OS, etc.). |  `-o wide` provides additional useful information                         |
| `kubectl describe node <node-name>` | Describes a specific node.          | Get details like allocated resources, taints, labels, etc.                                                           |

## Working with Namespaces

| Command                         | Description                                   | Notes                                                                                |
| :------------------------------ | :-------------------------------------------- | :----------------------------------------------------------------------------------- |
| `kubectl get namespaces`          | Lists all namespaces in the cluster.            |                                                                                      |
| `kubectl create namespace <name>` | Creates a new namespace.                      |                                                                                      |
| `kubectl delete namespace <name>` | Deletes a namespace.                          | Be *very careful* with this command! It deletes *all* resources in the namespace. |
| `kubectl describe namespace <name>` | Show namespace description |                                          |

## Working with Deployments

| Command                                                     | Description                                                                                                                                                                  | Notes                                                                                                                                          |
| :---------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- |
| `kubectl get deployments`                                   | Lists all deployments in the current namespace.                                                                                                                               | Use `-n <namespace>` to specify a different namespace.                                                                                       |
| `kubectl create deployment <name> --image=<image>`          | Creates a new deployment.                                                                                                                                                    | This is good for quick tests, but use YAML files for real deployments. `--replicas` can set initial number of replicas.                     |
| `kubectl apply -f <filename.yaml>`                           | Creates or updates resources (including Deployments) defined in a YAML file.                                                                                                   | This is the *recommended* way to manage Kubernetes resources.                                                                             |
| `kubectl describe deployment <name>`                        | Shows detailed information about a deployment.                                                                                                                               | Use this for troubleshooting. Check events, replica status, etc.                                                                          |
| `kubectl scale deployment <name> --replicas=<number>`       | Scales a deployment (changes the number of pods).                                                                                                                            |                                                                                                                                              |
| `kubectl rollout status deployment <name>`                   | Shows the status of a deployment rollout (e.g., during an update).                                                                                                             |                                                                                                                                              |
| `kubectl rollout history deployment <name>`                  | Shows the rollout history of a deployment.                                                                                                                                 |                                                                                                                                              |
| `kubectl rollout undo deployment <name>`                     | Rolls back a deployment to a previous revision.                                                                                                                               |                                                                                                                                              |
| `kubectl delete deployment <name>`                           | Deletes a deployment.                                                                                                                                                     |                                                                                                                                              |
| `kubectl edit deployment <deployment_name> -n <namespace>` | Edits a deployment.                                                                                                |                                                                                                                                              |

## Working with Pods

| Command                                                     | Description                                                                                       | Notes                                                                                                      |
| :---------------------------------------------------------- | :------------------------------------------------------------------------------------------------ | :--------------------------------------------------------------------------------------------------------- |
| `kubectl get pods`                                          | Lists all pods in the current namespace.                                                             | Use `-n <namespace>` to specify a namespace, `-o wide` for more details, and label selectors for filtering. |
| `kubectl get pods -o wide`                                  | Lists pods with more details (node, IP, etc.).                                                     |                                                                                                            |
| `kubectl get pods -n <namespace>`                           | Lists pods in a specific namespace.                                                                 |                                                                                                            |
| `kubectl get pods -l <label-selector>`                      | Lists pods matching a label selector (e.g., `-l app=nginx`).                                        | Very useful for finding pods related to a specific application.                                            |
| `kubectl get pods --show-labels`                            | Lists pods and show their labels.                                                                   |
| `kubectl describe pod <pod_name>`                         | Shows *detailed* information about a pod (status, events, container details, resource usage, etc.). | *Essential* for troubleshooting.  Look at the "Events" section first.                                       |
| `kubectl logs <pod_name>`                                  | Shows the logs from a pod's *main* container.                                                    |                                                                                                            |
| `kubectl logs <pod_name> -c <container_name>`                | Shows logs from a *specific container* within a pod (if there are multiple containers).                |                                                                                                            |
| `kubectl logs -f <pod_name>`                               | Shows logs from a pod and *follows* the logs (like `tail -f`).                                   | Very useful for monitoring a pod's output in real-time.                                                         |
| `kubectl exec -it <pod_name> -- <command>`                 | Executes a command *inside* a running container.                                                     | Use `/bin/bash` or `/bin/sh` to get an interactive shell.                                              |
| `kubectl delete pod <pod_name>`                             | Deletes a pod.                                                                                     | If the pod is managed by a Deployment, it will be recreated automatically.                                |
| `kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=<node-name>` | List all pods running on a specific node. Replace `<node-name>`                                              |                                  |
| `kubectl top pods`                              | Show resource usage (CPU, memory)                                             | Require metric server                 |

## Working with Services

| Command                               | Description                                                               | Notes                                                                                                                    |
| :------------------------------------ | :------------------------------------------------------------------------ | :----------------------------------------------------------------------------------------------------------------------- |
| `kubectl get services`                | Lists all services in the current namespace.                               | Use `-n <namespace>` to specify a namespace.                                                                             |
| `kubectl describe service <service_name>` | Shows detailed information about a service.                              | Check the `Endpoints` to see which pods are selected by the service.  Check the `Type` (ClusterIP, LoadBalancer, etc.). |
| `kubectl expose deployment <deployment_name> --port=<port> --target-port=<target_port> --type=<type>` | Creates a service to expose a deployment.                                   | `--type` can be `ClusterIP`, `NodePort`, `LoadBalancer`, or `ExternalName`.                                           |
| `kubectl delete service <service_name>` | Deletes a service.                                                         |                                                                                                                          |

## Working with Ingress
| Command                               | Description                                                               | Notes                                                                                                                    |
| :------------------------------------ | :------------------------------------------------------------------------ | :----------------------------------------------------------------------------------------------------------------------- |
| `kubectl get ingress`        | Lists all ingresses.                                            |                      |
| `kubectl describe ingress <ingress name>`        | Get details about ingress.                                            |                      |
| `kubectl apply -f <ingress.yaml>`        | Create/update ingress.                                            |                      |
| `kubectl delete ingress <ingress-name> -n <namespace>`        | Delete ingress.                                            |  This is *essential*.                    |

## Working with ConfigMaps and Secrets

| Command                                                     | Description                                                       | Notes                                                                              |
| :---------------------------------------------------------- | :---------------------------------------------------------------- | :--------------------------------------------------------------------------------- |
| `kubectl create configmap <name> --from-literal=<key>=<value>` | Creates a ConfigMap from literal values.                          | Useful for simple configurations.                                                  |
| `kubectl create configmap <name> --from-file=<file>`          | Creates a ConfigMap from a file.                                   |                                                                                    |
| `kubectl get configmaps`                                   | Lists ConfigMaps.                                                    |                                                                                    |
| `kubectl describe configmap <name>`                          | Shows details about a ConfigMap.                                      |                                                                                    |
| `kubectl create secret generic <name> --from-literal=<key>=<value>` | Creates a Secret from literal values.          | Use for sensitive data (passwords, API keys, etc.). **Never store secrets in plain text!** |
| `kubectl create secret generic <name> --from-file=<file>`   | Creates a Secret from a file.                            |                                                                                    |
| `kubectl get secrets`                                        | Lists Secrets.                                                       |                                                                                    |
| `kubectl describe secret <name>`                             | Shows details about a Secret (but *not* the secret data itself).      |                                                                                    |
| `kubectl get secret <name> -o jsonpath="{.data.<key>}" | base64 -d` |  **Get and decode** a secret value.| *Extremely* useful, but be careful with sensitive data.   |

## Working with Helm

| Command                             | Description                                                                          | Notes                                                                                                        |
| :---------------------------------- | :----------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------- |
| `helm repo add <repo_name> <url>`   | Adds a Helm repository.                                                                 | For example: `helm repo add argo https://argoproj.github.io/argo-helm`                                         |
| `helm repo update`                  | Updates your local list of available charts from all configured repositories.        | Run this before installing or searching for charts.                                                         |
| `helm search repo <keyword>`        | Searches for charts in the configured repositories.                                    | For example: `helm search repo argo`                                                                        |
| `helm install <release_name> <chart>` | Installs a chart.                                                                    | `<release_name>` is a name you choose for this specific installation. `<chart>` is the name of the chart.    |
| `helm install ... --namespace <ns>` | Installs the chart in a specific namespace.                                          | *Always* specify the namespace.                                                                           |
| `helm install ... --create-namespace` | Creates the namespace if it doesn't exist.                                             | Very useful for avoiding errors.                                                                           |
| `helm install ... --wait`            | Waits for all resources to become ready before completing the installation.           | *Highly recommended* for reliable deployments.                                                                |
| `helm install ... --timeout <duration>` | Sets a timeout for the `--wait` option (e.g., `--timeout 5m`, `--timeout 300s`).    | Prevents the installation from hanging indefinitely if resources don't become ready.                       |
| `helm install ... --version <version>` | Installs a *specific version* of the chart.                                          | *Essential* for reproducibility.  Don't rely on "latest".                                                  |
| `helm install ... -f <values.yaml>`   | Uses a `values.yaml` file to override default chart values.                          | *Best practice* for configuring Helm charts.                                                               |
| `helm install ... --set key=value`  | Overrides a specific chart value on the command line.                                | Useful for quick tests, but use `values.yaml` for complex configurations.                                   |
| `helm list -n <namespace>`          | Lists all Helm releases in a specific namespace.                                        |                                                                                                              |
| `helm uninstall <release_name> -n <namespace>` | Uninstalls a Helm release.                                                              | This *removes* the application deployed by the chart.                                                  |
| `helm get values <release_name> -n <namespace>` | Shows value that has been set during installation.                                                   |
| `helm status <release_name> -n <namespace>` | Show status of release.                                                   |

## Argo CD Specific Commands

| Command                                                                                                                               | Description                                                                                                 | Notes                                                                                                        |
| :------------------------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------- |
| `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`                                | Retrieves and decodes the initial Argo CD administrator password.                                        | Essential for logging in to the Argo CD UI for the first time.                                           |
| `kubectl apply -n argocd -f <argocd-application.yaml>`                                                                                | Creates/updates an Argo CD Application resource.                                                            | This defines how Argo CD will manage your application deployments.                                      |
| `kubectl get application -n argocd`                                                       | List all application.                   |                                              |
| `kubectl describe application <application name> -n argocd`                                                       | Get details of an application.                   |                                              |
| `kubectl port-forward svc/argocd-server -n argocd 8080:80`                                                             | Forwards port 8080 on your local machine to port 80 of the `argocd-server` service in the `argocd` namespace. | Use this for local access to the Argo CD UI without exposing it via a LoadBalancer or Ingress.              |

## Troubleshooting

| Command                                                     | Description                                                                                                                                                                 | Notes                                                                                                      |
| :---------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------- |
| `kubectl describe pod <pod_name> -n <namespace>`           | *Essential* for debugging pod issues.  Shows detailed information, including events, status, and container information.  Look for errors in the "Events" section.      |                                                                                                            |
| `kubectl logs <pod_name> -n <namespace>`                  | Shows the logs from the main container in a pod.                                                                                                                           | Use `-f` to follow the logs in real-time. Use `-c <container_name>` if there are multiple containers.     |
| `kubectl get events -n <namespace>`                         | Shows recent events in the specified namespace.  Very useful for identifying problems.                                                                                       |                                                                                                            |
| `kubectl get events --all-namespaces`                         | Shows recent events in the all namespaces.  Very useful for identifying problems.                                                                                       |                                                                                                            |
| `kubectl top pods -n <namespace>`                          | Shows CPU and memory usage for pods in a namespace (requires metrics-server).                                                                                                | Can help