# login to azure
az login

# deploy cluster and container registry
terraform init
terraform apply --autoapprove

# move generated kubeconfig file to ~/.kube/config (run commands without --kubeconfig param)
mv kubeconfig ~/.kube/config
## az aks get-credentials --resource-group aks_tf_rg --name aks_tf_rg

# check nodes
kubectl get nodes

# build docker image of hello world webserver, push to acr
az acr build --registry myazureregistry7532 --image hello-world:latest .

# deploy k8s manifest, deploys the container with image on the cluster
kubectl apply -f deployment.yaml

kubectl apply -f nginx.yaml

# check pods, use pod name to forward to local port for local testing
kubectl get pods

# If testing local: forward pod name to 8080 for http://localhost:8080 
kubectl port-forward $(kubectl get pod -l name=hello-world --no-headers | awk '{print $1}') 8080:8080

# start loadbalancer.yaml to expose pods on external ip
kubectl apply -f service.yaml

# Retrieve the load balancer's ip address, test External IP
kubectl get svc

# Delete Deployment, Delete Service
kubectl delete deploy testdeployment

kubectl delete service hello-world

##### Auto Scaling 
# check status of autoscaler
kubectl get hpa

# Test infinite requests ## Run this in a separate terminal
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
# type Ctrl+C to end

# To watch the Autoscaler:
# type Ctrl+C to end
kubectl get hpa php-apache --watch

# Kill Busy box requests with Ctrl + C

# check pod replicas
kubectl get deployment php-apache