There are multiple groups of API versions for K8s cluster
Example: /api, /version, /apis, /logs, /healthz, etc.

APIs responsible for cluster functionality
1) CORE GROUP = /api
--> /v1: namespaces, pods, nodes, pv, pvc, rc, events, endpoints, etc. 
2) NAMED GROUP = /apis 
# Example #1 
API GROUP: /apps
VERSION: v1 
RESOURCES:
/deployments
/replicaSets
/statefulSets 
VERBS: list, get, create, delete, update, watch
# Other examples of API Groups
API GROUP: /extensions
API GROUP: /networking.k8s.io (networkPolicies is a resource) 

# How to access all available group
curl http://localhost:6443 -k 



