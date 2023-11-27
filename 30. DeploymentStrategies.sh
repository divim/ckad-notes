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

# [IMPORTANT] BLUE GREEN DEPLOYMENT 
1 --> service called blue with old version v1 
2 --> service called green with new version v2 
3 --> test out blue & once it is passed, switch the label selector in "service"
# In the deployment YAML:
# the blue deployment is exactly the same except for metadata.name and image version 
metadata:
  name: myapp-green #here im specifying the green (new, v2) pods
spec: 
  template: 
    metadata: 
      name: myapp-pod 
      labels:
        version: v2 
    spec:
      containers: 
      - name: nginx 
        image: nginx:latest 
  replicas: 5 
  selector:
    matchLabels: 
      version: v2

# [IMPORTANT] Canary deployments 
1--> Create old "deployment-primary" version v1 
2--> Create new "deployment-canary" version v2 
3--> Route traffic to both versions 
3.1-> Ensure there is a common label between primary & canary. Example - app: front-end
3.2-> Ensure the service also uses selector on label app:front-end 
4--> Reduce traffic % to v2 
4.1-> Only create 1 (or a small number) replica for it 

# Limitation:
1. We have limited control of traffic 
2. We cant define %s, only values ----> this is where Istio comes in really handy 
