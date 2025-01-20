# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Download Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Install Minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube
minikube start --force

# Deploy todolistapp
kubectl run todolistapp --image=tomhuynhsg/react-todo-list-app

# Expose todolistapp within the cluster 
# Create a new service named 'todolistapp-service' that exposes the 'todolistapp' pod on a network, accessible via a NodePort at port 80
kubectl expose pod todolistapp --type=NodePort --port=80 --name=todolistapp-service

# Get the URL of the exposed service
minikube service todolistapp-service --url

# Forward the exposed service to the local machine
kubectl port-forward svc/todolistapp-service 3000:80 --address 0.0.0.0 &




# Monitoring
minikube status # Check the status of the Minikube cluster
kubectl get po -A # List all pods in all namespaces
kubectl get pods # List all pods in the default namespace
kubectl get events # List all events in the default namespace
kubectl get services # List all services in the default namespace
kubectl describe pod todolistapp # Describe the 'todolistapp' pod




#!/bin/bash

# URL of the website to check
URL="https://example.com"

# Fetch the website content and check for the <h1>hello world</h1> element
if curl -s "$URL" | grep -q '<h1>hello world</h1>'; then
    echo "The <h1>hello world</h1> element was found."
    exit 0  # Exit with success status (0)
else
    echo "The <h1>hello world</h1> element was NOT found."
    exit 1  # Exit with failure status (1)
fi