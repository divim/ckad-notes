# Features of a multi-container pods - they share:
1. The same lifecycle - they are created & destroyed together
2. Network space - referred to as local host
3. Storage volume - no need to establish volume sharing

# 3 design patterns:
1. Sidecar:
-> Extend the functionality of a container
--> Example 1 - Deploying a logging agent alongside a web agent
--> Example 2 - Implement HTTPS protocol to serve clients

2. Adapter:
-> Mediate access to a service or transform output
--> Example 1 - process the logs before sending it to the central server - unifies the data received
--> Example 2 - Used in canary deployments who rotate the desired percentage

3. Ambassador:
-> Adopt an exposed interface or proxy the connection
--> Example - Prometheus as the monitoring layer

# initContainers
-> initContainers run first to completion & then container is created
-> If initContainers fail, main container will not be created
-> if restartPolicy == never, then if initContainer fails, the overall pod is treated as failed
--> Example - checking the source code


# YAML File
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app.kubernetes.io/name: MyApp
spec:
  containers:
  - name: myapp-container
    image: busybox:1.28
    command: ['sh', '-c', 'echo The app is running! && sleep 3600']
  initContainers:
  - name: init-myservice
    image: busybox:1.28
    command: ['sh', '-c', "until nslookup myservice.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local; do echo waiting for myservice; sleep 2; done"]
  - name: init-mydb
    image: busybox:1.28
    command: ['sh', '-c', "until nslookup mydb.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local; do echo waiting for mydb; sleep 2; done"]
    