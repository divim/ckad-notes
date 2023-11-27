# Liveliness probes -> container to make the application more available
# Readiness probes -> container is ready to start accepting traffic
# Startup probes -> if the application running in the container has started

# Context: Many a times, the pod is "Running" but the container itself is not ready to accept responses/clients. So, it shows a "Site can't be reached" page despite it actually running just fine. 
# Question: How do you figure out whether it's an error or just loading? 
# Answer: You can set up probes ( tests)

# Readiness probes examples
- HTTP test: /api/ready
- TCP test: 3306 # checking DB connectivity
- exec command

# YAML file
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
    # TYPE 1 ---- HTTP readiness probe
    ports:
    - containerPort: 8080
    readinessProbe:
      httpGet:
        path: /api/ready
        port: 8080
      initialDelaySeconds: 10 # to delay your probe check
      periodSecond: 5         # to specify how frequently
      failureThreshold: 8     # to specify how many failures are acceptable
    
    # TYPE 2 ---- TCP Socket
    readinessProbe:
      tcpSocket:
        port: 8080
    
    # TYPE 3 -- exec
    readinessProbe:
      exec:
        command:
        - cat
        - /app/is_ready

# Logging 
k logs -f <file name with pod having container you want to monitor>

# Metrics server vs 3rd party addons (Prometheus, Elastic, Datadog, etc.)
Metrics server only stores it in-memory
--> It does not save it to the disk
--> If you want historic data, you need to use 3rd party components
