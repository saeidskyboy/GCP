# GKE Deployment with Terraform, GitHub Actions, Argo CD, and Monitoring

## Overview

This project automates the deployment of a Google Kubernetes Engine (GKE) cluster configured with essential applications using Terraform and GitHub Actions. The deployed stack includes:

* **Infrastructure:** GKE Cluster managed by Terraform.
* **Web Server:** Nginx deployment exposed via a LoadBalancer.
* **GitOps:** Argo CD for managing application deployments (installed via GitHub Actions).
* **Monitoring:** Prometheus and Grafana stack (Prometheus, Grafana, Node Exporter, Kube State Metrics) for cluster and application monitoring.

The deployment process is orchestrated through a series of chained GitHub Actions workflows.

## Prerequisites

Before you begin, ensure you have the following:

1.  **Google Cloud Platform (GCP) Account:**
    * A GCP project with billing enabled.
    * The following APIs enabled in your project:
        * Kubernetes Engine API
        * Cloud Resource Manager API
        * Compute Engine API
        * IAM API
        * Cloud Storage API
        * Service Usage API (often enabled by default)
2.  **GCS Bucket:** A Google Cloud Storage bucket created to store Terraform's remote state.
3.  **GCP Service Account:**
    * A Service Account created in your GCP project.
    * A JSON key file downloaded for this Service Account.
    * Appropriate IAM roles granted to the Service Account. See the **IAM Roles** section below.
4.  **Local Tools:**
    * [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed.
    * [Google Cloud SDK (`gcloud`)](https://cloud.google.com/sdk/docs/install) installed and authenticated (`gcloud auth login`).
    * [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) installed.
5.  **GitHub:**
    * A GitHub account.
    * A repository containing this project's code.

## Setup Instructions

### 1. Configure GCP Service Account & IAM Roles

* Create a Service Account in your GCP project.
* Grant the following IAM roles to the Service Account (Note: This list is based on common needs for this stack; you might refine it based on the principle of least privilege. Some roles listed in the initial draft might not be strictly necessary):
    * **Essential:**
        * `roles/container.admin` (Kubernetes Engine Admin) - Allows managing GKE clusters.
        * `roles/storage.admin` (Storage Admin) - Required for Terraform remote state bucket access.
        * `roles/iam.serviceAccountUser` (Service Account User) - Allows impersonating the service account (needed for Workload Identity or direct use).
        * `roles/compute.networkAdmin` (Compute Network Admin) - Often needed for GKE networking setup, LoadBalancers, Firewall rules.
        * `roles/compute.securityAdmin` (Compute Security Admin) - Often needed for Firewall rules.
    * **Potentially Needed (depending on Terraform/Actions setup):**
        * `roles/resourcemanager.projectIamAdmin` (Project IAM Admin) - If Terraform or Actions need to modify IAM policies. Use with caution.
        * `roles/iam.serviceAccountKeyAdmin` (Service Account Key Admin) - Only if the process needs to manage SA keys itself (usually not needed if you provide the key).
        * `roles/workloadidentity.workloadIdentityUser` (Workload Identity User) - If using GKE Workload Identity instead of key-based auth within the cluster.
* Create and download a JSON key file for this Service Account. You will use its content later.

**Important Note on `roles/container.admin`:** While powerful, this role is commonly used for full cluster management via automation. It differs slightly from `roles/container.clusterAdmin`, which is a Kubernetes RBAC role applied *within* the cluster. `roles/container.admin` grants broader GCP-level permissions over GKE resources.

### 2. Configure Terraform Backend

* Clone this repository to your local machine.
* Edit the `provider.tf` file (or relevant backend configuration file).
* Update the `backend "gcs"` block with the name of the GCS bucket you created for Terraform state.
    ```terraform
    terraform {
      backend "gcs" {
        bucket = "YOUR_GCS_BUCKET_NAME_HERE" # <-- Update this
        prefix = "terraform/state"
      }
    }
    ```
* Optionally, run `terraform init` locally to ensure the backend configuration is correct.

### 3. Configure GitHub Actions Secrets

* Navigate to your GitHub repository -> Settings -> Secrets and Variables -> Actions.
* Click "New repository secret".
* Create a secret named `GCP_PROJECT_ID`:
    * Paste your GCP Project ID as the value.
* Create another secret named `GCP_ACCESS_KEY`:
    * Paste the **entire JSON content** of the downloaded Service Account key file as the value.

## Deployment via GitHub Actions

The deployment is managed by chained GitHub Actions workflows defined in the `.github/workflows/` directory.

1.  **`gke-deploy-workflow.yml`:**
    * **Trigger:** Push to the `main` branch OR manual trigger (`workflow_dispatch`). (Note: Changes to workflow files themselves usually don't trigger pushes).
    * **Action:** Uses Terraform to provision/update the GKE cluster infrastructure based on the `.tf` files.
2.  **`app-deploy-workflow.yml`:**
    * **Trigger:** Successful completion of `gke-deploy-workflow.yml` OR manual trigger.
    * **Action:** Deploys the Nginx webserver, creates required namespaces (e.g., `argocd`, `monitoring`), and potentially configures LoadBalancer services needed for Nginx and Argo CD access.
3.  **`install-argocd-workflow.yml`:**
    * **Trigger:** Successful completion of `app-deploy-workflow.yml` OR manual trigger.
    * **Action:** Installs Argo CD into the cluster using its manifests or Helm chart.
4.  **`install-prometheus-grafana.yml`:**
    * **Trigger:** Successful completion of `install-argocd-workflow.yml` OR manual trigger.
    * **Action:** Deploys the Prometheus and Grafana monitoring stack components (Deployments, ConfigMaps, Services, RBAC, etc.) defined in the `monitoring/` directory.

Simply push your code changes (excluding workflow files themselves if using the push trigger) to the `main` branch to initiate the sequence, or trigger the first workflow manually from the GitHub Actions tab.

## Accessing Deployed Services

Once the workflows complete successfully:

1.  **Connect `kubectl`:** If you haven't already, configure `kubectl` to connect to your new cluster:
    ```bash
    gcloud container clusters get-credentials <YOUR_CLUSTER_NAME> --zone <YOUR_CLUSTER_ZONE> --project <YOUR_PROJECT_ID>
    ```
2.  **Find Service IPs:** Get the external IP addresses assigned to the LoadBalancer services:
    ```bash
    kubectl get svc -n default   # For Nginx LoadBalancer
    kubectl get svc -n argocd    # For Argo CD LoadBalancer
    kubectl get svc -n monitoring # For Grafana and Prometheus LoadBalancers
    ```
    *Look for services of `TYPE=LoadBalancer` and copy their `EXTERNAL-IP`.*
3.  **Access UIs:** Open the external IPs in your web browser (usually on HTTP/Port 80 unless configured otherwise):
    * Nginx: `http://<nginx-external-ip>`
    * Argo CD: `http://<argocd-external-ip>`
    * Grafana: `http://<grafana-external-ip>`
    * Prometheus: `http://<prometheus-external-ip>` (If exposed via LoadBalancer)

## Verification Steps

* **Check Nodes & Pods:**
    ```bash
    kubectl get nodes
    kubectl get pods -A # Check pods across all namespaces
    ```
* **Check GCS Bucket Access (from within a test pod):**
    * Find a running pod (e.g., in the `default` or `staging` namespace if you created one): `kubectl get pods -n default`
    * Exec into the pod (replace pod name): `kubectl exec -n default -it <your-pod-name> -- /bin/bash`
    * If `gcloud` is installed in the pod's image, try: `gcloud alpha storage ls` (You might need to install `gcloud` or use a different method depending on the pod image). This verifies the underlying node's service account (or Workload Identity) permissions if configured.

## Troubleshooting Common Issues

* **GitHub Actions Failures:**
    * Check the detailed logs for the failed step in the GitHub Actions UI.
    * Verify `GCP_PROJECT_ID` and `GCP_ACCESS_KEY` secrets are correctly set in repository settings.
    * Ensure the Service Account has all the necessary IAM permissions listed in the setup section.
    * Check for Terraform plan/apply errors in the logs.
* **Pod Errors (Pending, CrashLoopBackOff, Error):**
    * Get logs: `kubectl logs <pod-name> -n <namespace>`
    * Get detailed description: `kubectl describe pod <pod-name> -n <namespace>` (Look for Events, Status, Reason).
* **Prometheus Startup Errors:**
    * Check Prometheus pod logs (`kubectl logs <prometheus-pod> -n monitoring`).
    * Errors often relate to parsing `prometheus.yml` from the `prometheus-config` ConfigMap.
    * **YAML Syntax:** Carefully check indentation, ensure list structures are correct (especially for `kubernetes_sd_configs` which requires `- role: ...`), and avoid invalid syntax like using semicolons for multiple keys on one line. The error log usually points to the problematic line number.
* **OOMKilled Errors (Prometheus or other pods):**
    * `kubectl describe pod <pod-name> -n <namespace>` will show `Reason: OOMKilled` in the `Last State`.
    * This means the container exceeded its memory limit.
    * **Solution:** Edit the corresponding Deployment YAML file (e.g., `monitoring/prometheus-deployment.yml`). Increase the `resources.limits.memory` value (e.g., to `512Mi` or `1024Mi`) and likely `resources.requests.memory`. Apply the changes: `kubectl apply -f <path-to-deployment.yaml>`.
* **DaemonSet Errors (e.g., Node Exporter):**
    * Check logs and `describe` output for the DaemonSet pods.
    * Apply errors often indicate validation issues (e.g., missing `image:` field in the container spec). Correct the DaemonSet YAML and re-apply.
* **LoadBalancer IP Pending:**
    * It can take a few minutes for GCP to provision and assign an external IP. Check status: `kubectl get svc -n <namespace>`. If it persists, check GCP Cloud Console Load Balancing section or `kubectl describe svc <service-name> -n <namespace>` for events.

## Cleanup

* A fifth workflow, `destroy-workflow.yml` (or similar name), is provided for cleanup.
* **Trigger:** This workflow can **only** be triggered manually from the GitHub Actions tab.
* **Action:** Executes `terraform destroy` (or equivalent steps) to remove the GKE cluster and all resources created by Terraform.
* **Manual Step:** The GCS bucket used for Terraform state is **not** deleted by the workflow. You must manually delete this bucket via the GCP Console or `gcloud` if you want a complete cleanup.

---
*Feel free to add specific version numbers for tools if needed, or further details about Nginx/Argo CD configuration access.*