# roles + rolebindings -> for namespace-specific resources
# clusterroles + clusterbindings -> for cluster-specific resources

# to see all api resources 
k api-resources --namespaced=true

# YAML is same as role & roleBindings 
apiVersion: rbac.authorization.k8s.io
kind: ClusterRole 
metadata:
    name: cluster-administrator 
rules: 
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["list", "get", "create", "delete"]

