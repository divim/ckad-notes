Types of authorization: 
1) Node authorization
-> this is for when the kubelets accesses the nodes for getting/reporting info 
2) ABAC (Attribute-based)
-> difficult to manage
-> edit the files directly for each user 
3) RBAC (Role-based)
-> associate user to Role 
-> modify role to managing access 
4) Webhook 
-> externally manage authz 
5) AlwaysAllow
-> default version 
-> set it at the kube-apiserver authorization mode 
6) AllowDeny 
-> to override default version 
-> node => RBAC => user is granted access 

# ---- To check what authorization is being used on kube-api server
k describe pod kube-apiserver-controlplan -n kube-system 

# -------------------RBAC------------
Step 1: Create the role 
# YAML file for a role
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
    name: developer 
rules: 
- apiGroups: [""]   # You can leave this blank for CORE group 
  resources: ["pods"]
  verbs: ["list", "get", "create"]
  resourceNames: ["blue", "orange"] # optional if you wanna be more granular 


Step 2: Link the user to the Role
# YAML file for a role binding 
apiVersion: rbac.authorization.k8s.io 
kind: RoleBinding 
metadata: 
    name: dev-rolebinding 
subjects: 
- kind: User 
  name: dev-user 
  apiGroup: rbac-authorization.k8s.io
roleRef: 
    kind: Role
    name: developer
    apiGroup: rbac.authorization.k8s.io 


Step 3: 
# To view created roles
k get roles 
k get rolebindings 
# To describe roles/rb 
k describe role <role-name>
k describe rolebinding <rolebinding> 
# To check access 
k auth can-i <verb> <object> 
k auth can-i create deployments 
k auth can-i delete nodes 
# To check other admins 
k auth can-i <verb> <object> --as <role> 
k auth can-i create deployments --as dev-user 
