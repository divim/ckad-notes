# create a deployment
k create deploy nginx-deploy
                --image=nginx 
                --dry-run
                -o yaml
                --replicas=4

# scale a deployment 
k scale deploy nginx-deploy --replicas=4

# YAML for deployment
# Required fields are apiVersion, kind, metadata, spec
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80

# check rollout status of your deployment
k rollout status deployment/<deployment-name>
# check history of rollouts
k rollout history deployment/<deployment-name>
k rollout history deployment nginx --revision=1

# [IMPORTANT] You can record a certain change to the deployment with "--record"
k set image deployment nginx nginx=nginx:1.17 --record

#you can also perform rollbacks
k rollout undo deployment/<deployment-name>

# Deployment strategies
1) Recreate: delete all old pods, recreate new ones (has downtime)
2) RollingUpdate: take down & bring up one by one 
3) Blue-green: Split 50% old (blue) and 50% new (green) -> once all tests are passed, switch to green 
4) Canary: route traffic to both versions v1 and v2 & route small % to v2 