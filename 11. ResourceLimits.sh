# request = how much the system can guarantee
# limit = how much a container can be allowed
# CPU units = 0.5, 1, 2, etc.
# Memory units = Ki, Mi, Gi

# fetch the metrics for the pod
k top pod <pod-name> 

# sample of setting resource requests/limits:
apiVersion: v1
kind: Pod
metadata:
  name: memory-demo
  namespace: mem-example
spec:
  containers:
  - name: memory-demo-ctr
    image: polinux/stress
    resources:
      requests:
        memory: "100Mi"
        cpu: "1"
      limits:
        memory: "200Mi"
        cpu: "2"
    command: ["stress"]
    args: ["--vm", "1", "--vm-bytes", "150M", "--vm-hang", "1"]

