# HELP
# This will output the help for each task
.PHONY: help

help: ## This is help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# Get cluster status
status:
	kubectl get nodes
	kubectl get deployments
	kubectl get pods -owide
	kubectl get svc

deploy: ## Apply Deployment & Loadbalancer
	kubectl apply -f stable-d.yaml
	kubectl apply -f service.yaml

test: ## Apply Testing deployment and test loadbalancer
	kubectl apply -f test-d.yaml
	kubectl apply -f service.yaml
	kubectl apply -f autoscaler.yaml

delete: ## Delete Deployment & Loadbalancer
	kubectl delete deploy stabledeployment
	kubectl delete service my-service

stop: ## Delete Testing deployment and test loadbalancer
	kubectl delete deploy testdeployment
	kubectl delete service my-service