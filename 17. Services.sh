# 3 types of services: (1) NodePort (2) ClusterIP (3) LoadBalancer

# NodePort
1. TargetPort: port on the pod
2. Port: Port on the service 
3. NodePort: node port used to access cluster externally

#  YAML Definition
apiVersion: v1
kind: Service 
metadata:
    name: myapp-nodeport 
spec: 
    type: NodePort     # can also be ClusterIP or LoadBalancer
                        # ClusterIP is not specified 
    ports:
    - targetPort: 80    # if left empty, is assumed to be port
      port: 80          # the only mandatory field
      nodePort: 30008   # this can be only in a certain range of 30,000 - 32,767
    selector:
      app: myapp
      type: front-end


    


