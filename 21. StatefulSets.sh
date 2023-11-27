WHY DO YOU NEED THIS? How to perform DB replication?
# In deployments 
# -> all pods come up at the same time
# -> Pods change IP address, have random names --> it can't be possible to point out master pod 
# -> no determined network ID

# In StatefulSets
# -> Pods are created in a sequential order 
# -> Ensures that master is deployed first
# -> Names are given incrementally (not random like deployments) 
# -> Maintain a sticky state
# -> stateful & unique network ID

HOW TO DO STATEFULSET?
exactly like deployments, except kind & adding "serviceName" in spec 
kind: StatefulSets
spec: 
    serviceName: mysql-h
    podManagementPolicy: Parallel # if you dont want it to be sequential 

HEADLESS SERVICES: 
-> like a Service but without an IP address (no clusterIP assigned)
-> It just creates DNS ENTRYPOINT: <pod>.<service>.<namespace>.svc.cluster.local 
-> the only difference with a normal service is that clusterIP is set to none 
# IN THE SERVICE FILE
apiVersion: v1
kind: Service 
metadata: 
    name: mysql-h 
spec: 
    ports: 
    - port: 3306
    selector:
        app: mysql 
    clusterIP: None # THIS IS THE DIFFERENCE 
# IN THE DEPLOYMENT'S POD FILE
apiVersion: v1
kind: Pod
metadata:
    name: myapp-pod
spec:
    containers:
    - name: mysql 
      image: mysql
    subdomain: mysql-h  # (needed for headless) SAME AS THE NAME OF THE SERVICE
    hostname: mysql-pod     # (needed for headless) CREATES THE A NAME RECORD 

# IN THE DEPLOYMENT/STATEFULSET FILE
apiVersion: v1              # this becomes apps/v1 for deployment
kind: StatefulSet           # this becomes deployment 
metadata:
    name: myapp-stateful 
spec:   
    serviceName: mysql-h    # ONLY FOR DEPLOYMENT - YOU DONT NEED TO SPECIFY hostname/subdomain IN STATEFULSETS
    replicas: 3
    matchLabels:
        app: mysql
    template: 
        containers:
        - name: mysql 
        image: mysql
    volumeClaimTemplate:    #STORAGE in StatefulSets 
    - metadata:
        name: data-volume 
      spec:     
        accessModes: 
        - ReadWriteOnce 
      storageClassName: google-storage 
      resources: 
        requests: 
            storage: 500Mi 
       


