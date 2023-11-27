#---------------Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379

# Option 1
# Automatically use the pod's labels as selectors
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml

# Option 2
# This will not use the pods labels as selectors, instead it will assume selectors as app=redis. 
# You cannot pass in selectors as an option. So it does not work very well if your pod has a different label set. 
# So generate the file and modify the selectors before creating the service
kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml



#---------------Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes

# Option 1
# This will automatically use the pod's labels as selectors, but you cannot specify the node port. 
# You have to generate a definition file and then add the node port in manually before creating the service with the pod.
kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml

# Option 2
# This will not use the pods labels as selectors
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml

#---------------IMPORTANT-------------------------------------------------------------------
# Both the above commands have their own challenges. 
# While one of it cannot accept a selector the other cannot accept a node port. 
# I would recommend going with the `kubectl expose` command. 
# If you need to specify a node port, generate a definition file using the same command 
# and manually input the nodeport before creating the service.
