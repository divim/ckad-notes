# For the following use cases:
# a. restricting a pod to run on a particular node
# b. preferring to run on a particular node

# These are the possibilities to choose where to schedule pods
# 1. nodeSelector field matching against node label
# 2. affinity and anti-affinity
# 3. nodeName
# 4. Pod topology spread constraints

#-----------------NODESELECTOR (has limitations)-----------
k label nodes <node-name> size=Large
# Limitation = you can't have advanced selectors 
# # what if there's size=Large or size=Medium
# # what about anything except for small

#-----------------NODEAFFINITY (better)--------------------
# In the YAML file for operator, your options are:
In, NotIn, Exists, DoesNotExist, Gt, Lt 

# 3 types of node affinity:
1. requiredDuringSchedulingIgnoredDuringExcecution
# ^ during scheduling - if not, pod will not be created (nothing happens if node labels change during execution)
2. preferredDuringSchedulingIgnoredDuringExcecution
# ^ try your best, then it's okay  (nothing happens if node labels change during execution)
3. requiredDuringSchedulingRequiredDuringExcecution
# ^ if anything is changed with nodel labels, then the pod is kicked out


# YAML example
apiVersion: v1
kind: Pod
metadata:
  name: with-node-affinity
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: topology.kubernetes.io/zone
            operator: In
            values:
            - antarctica-east1
            - antarctica-west1
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: another-node-label-key
            operator: In
            values:
            - another-node-label-value
  containers:
  - name: with-node-affinity
    image: registry.k8s.io/pause:2.0