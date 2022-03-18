# Stable Release 1.0

### Terraform files
- Creates a Resource Group on Azure
- Creates a cluster with 2 nodes
- Creates an Azure Container Registry

`terraform init`
`terraform plan`
`terraform apply`
`terraform destroy`

### After Terraform deploys the cluster, move the kubeconfig file to its folder:
`mv kubeconfig ~/.kube/config`

### Makefile for YAML files & kubecommands
- Check status of cluster
`make status`
---
- Deploy 3 pod instances on the cluster
- Deploy a Load Balancer which exposes the cluster on an External IP
`make deploy`
---
- Delete the Production resources
`make delete`
---
- Delete and Redploy the Production resources (if updating the image release)
`make refresh`
---
- Deploy a test deployment of 3 pods on the cluster
- Deploy a test Load balancer for the test deployment
`make test`
---
- Delete the test resources
`make stop`

### Dockerfile & .html
- Build an nginx image with Alpine OS
- Move the HTML file into the Alpine directory on the image
- Test changes on the HTML file and rebuild the image for deployment
- This repo auto releases the image with Github Actions

### gitignore
- Terraform.tfvars is removed from the commit
- Terraform generated files are removed; especially state and lock files
- Example tfvars is included in the commit for disaster recovery

### Redundant files for development
- test deployment contains helloworld image in this release
- test loadbalancer service for a deployment with a php image
- index.php contains an algorithm for generating cpu load
- Nginx load balancer nginx.config - in development

### create.sh 
- ! Don't try to run
- list of commands from the start of project & more for further testing