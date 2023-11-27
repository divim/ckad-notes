# Four initial namespaces
# default 
# kube-system: ns for objects created by k8s system
# kube-public: readable by all users -> cluster usage
# kube-node-lease: Lease objects associated with each -> allows to send heartbeats

# Set a default namespace
kubectl config set-context --current --namespace=<insert-namespace-name-here>
# Or you can 
alias nsu=--namespace=newname


# ------------------IMPORTANT---------------------<service>.<ns>.svc.cluster.local
# When you create a Service, it creates a corresponding DNS entry. 
# This entry is of the form <service-name>.<namespace-name>.svc.cluster.local
# If a container only uses <service-name>, it will resolve to the service which is local to a namespace. 
# If you want to reach across namespaces, you need to use the fully qualified domain name (FQDN).


# In a namespace
kubectl api-resources --namespaced=true

# Not in a namespace (example: nodes, persistentVolumes)
kubectl api-resources --namespaced=false