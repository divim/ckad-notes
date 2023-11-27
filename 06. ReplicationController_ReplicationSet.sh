# ReplicationController & ReplicaSet:
#     Provides high availability through scaling -> provides more than one pod running at the same time
#     Helps share load across multiple pods & multiple nodes
#     ReplicaSet -> selector as mandatory to define the pods it's using
#     ReplicationController -> selector as optional 
#                             -> if nothing is provided, it assumes the ones from the labels of the pod


# NOTE! 
# You will see 2 sets of labels 
# -> one is metadata (the laber of the replicaset itself)
# -> other is the selector (the pods with matching labels you want to choose)

# ReplicaSet YAML file
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  labels:
    app: guestbook
    tier: frontend
spec:
  # modify replicas according to your case
  replicas: 3
  selector:
    matchLabels:
      tier: frontend
  template: #template = pod definition basically
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: gcr.io/google_samples/gb-frontend:v3

# ReplicationController YAML file 
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    app: nginx
  template: #template = pod definition basically
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
