# create a pod directly & run it with labels
k run hello-world --image=httpd:alpine 
                --port=80 
                --expose 
                --labels=tier=db

#get pods information with nodes, IP addresses
k get pods -o wide

# get pods with label devtier
k get pods --selector env=dev 

# YAML definition for Pods
apiVersion: v1
kind: Pod
metadata:
  name: nginx-demo
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    command: ["sleep"]  #equivalent to ENTRYPOINT in Dockerfile
    args: ["5"]         #equivalent to CMD in Dockerfile
    ports:
    - containerPort: 80
  restartPolicy: Never  # always set it to Never unless it's meant to always be on

  subdomain: mysql-h # If you want to create a headless service 
# • What CAN you edit in an existing pod?
	○ Spec.containers.image
	○ Spec.initcontainers.image

	○ Spec.activeDeadlineSeconds
	○ Spec.tolerations 
# • What you CANNOT edit in an existing pod?
	○ Resource limits
	○ ENV variables
	○ Service accounts
# • If you really have to:
k edit pod <pod-name>
k get pod <pod-name> -o yaml > podDefinitions.yaml
# • Edit deployment: 
k edit deployment <deployment-name>

# You need to edit the restartPolicy of a Pod
Default is true -> this demands the kubernetes server to keep the pod alive
Override it to false -> this needs to be mentioned so that the pod can finish the task & exit 