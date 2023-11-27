PATH for kubeconfig: $HOME/.kube/config
kubeconfig file has 3 main parts:
1. Clusters (dev, prod, etc.)
2. Contacts (<user>@<cluster>, admin@prod, dev@dev)
3. Users (admin, dev user, prod user, etc.)

# Typical command to connect with certificates
--server kube-cluster:6443  # cluster 
--client-key admin.key #user
--client-certificate admin.crt # user
--certificate-authority ca-crt #user

# HOw to view the config file 
k config view 
# How to change context 
k config --kubeconfig=<path> use-context prod-user@prod-cluster 
k config --kubeconfig=/root/config-new use-context prod-user@prod-cluster 

# kubeConfig YAML file
apiVersion: v1
kind: Config 
current-context: dev-admin@devcluster # default context 
clusters:
- name: prod 
  cluster:
    certificate-authority: ca.crt # or "/etc/kubernetes/pki/ca.crt"
    #OR "certificate-authority-data: DSKLFGD" - here DSKLFGD = echo "___certificate content___" | base 64
    server: https://prod-cluster:6443
contexts: 
- name: kubeadmin@prod 
  context:
    user: kubeadmin 
    cluster: prod 
    namespace: finance-ns 
users: 
- name: kubeadmin
  user: 
    client-certificate: admin.crt 
    client-key: admin.key 



