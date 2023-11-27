# 1. Taint set on nodes --> mosquito repellant 
# 2. Toleration set on pods --> mosquito itself

# By default, no pods have any tolerations
# Specify what pods can be tolerant to a certain taint

# --------------APPLY TAINT TO NODES----------- 
k taint nodes <node-name> <key>=<value>:<taint-effect>
k taint nodes foo dedicated=specialuser:NoSchedule
# # <effect> types - 3 taint effects: 
1. NoSchedule: 
    pod will not be scheduled on this node without a matching toleration
    if pods exist, they wont be evicted
2. PreferNoSchedule: 
    try to avoid placing pods on this node
3. NoExecute: 
    new pods will not be scheduled on the node 
    if pods exist, they will be evicted


# remove from node 'foo' the taint with key 'dedicated' and effect 'NoSchedule' 
k taint nodes foo dedicated:NoSchedule-
# remove from node 'foo' all taints with key 'dedicated'
k taint nodes foo dedicated-
# add a taint with key 'dedicated' on nodes having label mylabel=X
k taint node -l myLabel=X dedicated=foo:PreferNoSchedule

# --------------APPLY TOLERATION TO PODS----------- 
# how to define operator?
# # default value for operator is "Equal" (with value specified)
# # alternatively, operator is Exists (no value needs to be specified)


# Sample of pod 
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  tolerations:
  - key: "example-key"
    operator: "Exists"  #doesnt need a value
    effect: "NoSchedule"
  - key: "key1"
    operator: "Equal"   #needs a value
    value: "value1"
    effect: "NoExecute"
    tolerationSeconds: 3600 #you can add this only for NoExecute



