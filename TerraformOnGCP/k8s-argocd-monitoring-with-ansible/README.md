Instead of trying to add SSH keys for a human user, create a dedicated service account for SSH access
this service account is better to be creatged manually, grant below rules to it	
Compute OS Admin Login
Compute OS Login
Secret Manager Admin
Service Account Token Creator
Storage Object Admin
then create a key and attach it to this account
save the saervice account email into github secret (I named it SSH_SA_EMAIL) and save its key value also to github secret (which I named it SSH_SA_KEY)

core concept of using os-login and ssh key between ansible controller and gke nodes:
Ansible controller VM, running as its Service Account (GCP_SA_EMAIL), needs to use the private key (fetched from Secret Manager) to connect via SSH to the GKE nodes. The GKE nodes, using OS Login, will authenticate this connection by checking if the corresponding public key exists in the OS Login profile associated with the Ansible Controller VM's Service Account (GCP_SA_EMAIL), and verifying IAM permissions.