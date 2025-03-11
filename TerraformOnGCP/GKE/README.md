# GKE Cluster with Argo CD and Nginx (via GitHub Actions - Simplified)

This repository provides a simplified setup for deploying a Google Kubernetes Engine (GKE) cluster, installing Argo CD, and deploying a basic Nginx web server, all automated through GitHub Actions.  This version uses **separate, manually triggered workflows** for each stage, making it easier to understand and troubleshoot.  It uses direct `kubectl` commands for Argo CD installation, rather than Helm, for simplicity.

**What's Included:**

*   **GKE Cluster:** A managed Kubernetes cluster on Google Cloud.
*   **Argo CD:** A declarative, GitOps continuous delivery tool (installed via `kubectl apply`).
*   **Nginx:** A simple web server to demonstrate a basic application deployment.
*   **LoadBalancer:** Google Cloud LoadBalancers to expose Nginx and Argo CD.
*   **GitHub Actions:** Three separate workflows for:
    *   Creating the GKE cluster (Terraform).
    *   Deploying Nginx (and creating the `argocd` namespace).
    *   Installing Argo CD.

**Directory Structure:**
2.0 Pro Experimental. Lacks access to real-time info and some Gemini features.
Okay, I understand. You want me to update the README.md to reflect the current setup: three separate workflows (gke-cluster.yaml, deploy-app.yaml, install-argocd.yaml), manual triggering, direct kubectl apply for Argo CD, and the removal of Ansible.  You also want the instructions to be clear and geared towards someone who might be new to this.

Here's a revised README.md, incorporating all the changes and explanations:

Markdown

# GKE Cluster with Argo CD and Nginx (via GitHub Actions - Simplified)

This repository provides a simplified setup for deploying a Google Kubernetes Engine (GKE) cluster, installing Argo CD, and deploying a basic Nginx web server, all automated through GitHub Actions.  This version uses **separate, manually triggered workflows** for each stage, making it easier to understand and troubleshoot.  It uses direct `kubectl` commands for Argo CD installation, rather than Helm, for simplicity.

**What's Included:**

*   **GKE Cluster:** A managed Kubernetes cluster on Google Cloud.
*   **Argo CD:** A declarative, GitOps continuous delivery tool (installed via `kubectl apply`).
*   **Nginx:** A simple web server to demonstrate a basic application deployment.
*   **LoadBalancer:** Google Cloud LoadBalancers to expose Nginx and Argo CD.
*   **GitHub Actions:** Three separate workflows for:
    *   Creating the GKE cluster (Terraform).
    *   Deploying Nginx (and creating the `argocd` namespace).
    *   Installing Argo CD.

**Directory Structure:**

GCP/
├── .github/workflows/
│   ├── deploy-app.yaml         <-- Deploys Nginx and creates argocd namespace
│   ├── gke-cluster.yaml      <-- Creates the GKE cluster
│   └── install-argocd.yaml    <-- Installs Argo CD
│   └── destroy-gke-cluster-workflow.yaml <-- Destroys cluster
└── TerraformOnGCP/
└── GKE/
├── main.tf             <-- Main Terraform configuration
├── outputs.tf          <-- Terraform outputs
├── node-pools.tf       <-- Defines the GKE node pool
├── ansible/            <-- (Now Unused - Can be Removed)
└── k8s-configs/         <-- Kubernetes YAML manifests
├── deployment.yml      <-- Nginx deployment
└── lb-and-ingress-svc.yml  <-- Nginx and ArgoCD LoadBalancer services

**Prerequisites:**

*   **Google Cloud Account:**  A GCP account with billing enabled.
*   **Google Cloud Project:**  A GCP project (note your Project ID).
*   **GitHub Account:** A GitHub account to fork this repository.
*   **gcloud CLI:** Install and configure the Google Cloud SDK (`gcloud`) locally: [https://cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install)
*   **kubectl:** Install `kubectl`: [https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/)
*   **Helm:**  Install Helm: [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/)
*   **(Optional) Domain Name:**  For TLS with cert-manager (recommended for production).

**Setup:**

1.  **Fork and Clone:** Fork this repository and clone your fork.

2.  **Service Account:**
    *   Create a service account in your GCP project (e.g., `terraform-deployer`).
    *   Grant the following roles to the service account:
        *   `roles/container.clusterAdmin` (at the *project* level)
        *   `roles/storage.objectAdmin`
        *   `roles/iam.serviceAccountUser`
        *   `roles/compute.instanceAdmin.v1`
        *   `roles/compute.networkAdmin`
        *   `roles/compute.securityAdmin`
        *   `roles/iam.roleViewer`
        *   `roles/storage.admin`
    *   Create and download a JSON key file for the service account.

3.  **GitHub Secrets:**
    *   In your *forked* GitHub repository, go to "Settings" -> "Secrets and variables" -> "Actions".
    *   Create these repository secrets:
        *   `GCP_ACCESS_KEY`: Paste the *entire content* of the service account JSON key.
        *   `GCP_PROJECT_ID`: Your GCP project ID.

4.  **Terraform Backend:**
    *   Create a GCS bucket to store your Terraform state:
        ```bash
        gsutil mb -p <YOUR_PROJECT_ID> -l us-central1 gs://<YOUR_BUCKET_NAME>
        ```
    *   Update `TerraformOnGCP/GKE/main.tf`: Change `bucket = "your-terraform-state-bucket"` to use your actual bucket name.

5.  **Enable APIs:** Enable these APIs in your GCP project:
    *   Compute Engine API
    *   Kubernetes Engine API
    *   Cloud Resource Manager API
    *   IAM API

**Deployment Options:**

This repository is set up with **automatic, sequential workflow triggering**:

*   **`gke-deploy-workflow.yaml`:** Creates the GKE cluster.  Triggered on pushes to the `main` branch in the `TerraformOnGCP/GKE/` directory, *and* manually.
*   **`app-deploy-workflow.yaml`:** Deploys Nginx. Triggered *automatically* after `gke-deploy-workflow.yaml` completes successfully, *and* manually.
* **`install-argocd-workflow.yaml`:** Installs ArgoCD. Triggered *automatically* after `app-deploy-workflow.yaml` completes successfully, *and* manually.

**To use only manual triggering:**

1.  **Edit `app-deploy-workflow.yaml`:**  Remove the `workflow_run` trigger, leaving only `workflow_dispatch`:

    ```yaml
    on:
      workflow_dispatch:
    ```

2.  **Edit `install-argocd-workflow.yaml`:** Remove the `workflow_run` trigger, leaving only `workflow_dispatch`:
     ```yaml
    on:
      workflow_dispatch:
    ```

**Manual Deployment Steps (After Setup):**

1.  **Run `gke-deploy-workflow.yaml`:**  Go to "Actions", select "Deploy GKE Cluster", and click "Run workflow".
2.  **Run `app-deploy-workflow.yaml``:** After the cluster is created, run the "Deploy Application" workflow.
3. **Run `install-argocd-workflow.yaml`:** After Nginx is deployed, run the  "Install Argo CD" workflow.
4.  **Access Nginx and Argo CD:**  Get the external IPs using `kubectl get svc -n default` (for Nginx) and `kubectl get svc -n argocd` (for Argo CD). Access them in your browser.

**Cleaning Up:**

Run the "Destroy GKE Cluster" workflow.

**Important Notes:**

*   **Hardcoded Values:** The `app-deploy-workflow.yaml` and `install-argocd-workflow.yaml` currently uses *hardcoded* values for the cluster name and zone.
*   **TLS:** This setup initially installs Argo CD *without* TLS (using `--insecure`).  For production, you *must* configure TLS.