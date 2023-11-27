# Container settings override pod settings
# Container settings dont affect pod volumes
# allowPrivilegeEscalation: Controls whether a process can gain more privileges than its parent process
# Security context

# HOW TO SEE WHO ARE YOU?
# # 1. WHOAMI
k get pods 
# ^ take note of pod name
k exec <pod-name> -- whoami
# ^ you see the user running it

# # 2. ps & check your user ID
k exec -it <pod-name> -- sh
ps 

# YAML example:
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  volumes:
  - name: sec-ctx-vol
    emptyDir: {}
  containers:
  - name: sec-ctx-demo
    image: busybox:1.28
    command: [ "sh", "-c", "sleep 1h" ]
    volumeMounts:
    - name: sec-ctx-vol
      mountPath: /data/demo
    securityContext:
      allowPrivilegeEscalation: false # Controls whether a process can gain 
                                      # more privileges than its parent process
