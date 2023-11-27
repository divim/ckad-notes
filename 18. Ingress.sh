apiVersion: networking.k8s.io/v1

# The idea of an ingress 
Every time you create a LoadBalancer, an explicit load balancer is created for each of your application components
-> How will you control the rules for routing?
-> Costs are high with this
Answer = INGRESS 

# ingress:
-> L7 load balancer w/ security SSL
-> allows communication from outside on port 80 and 443
-> holds routing rules based on hostnames & paths
-> examples: ngnix, HAProxy, traefik

# what you need:
1. DEPLOY an ingress controller (eg: nginx)
    -> create deployment file with simple pod definition
    -> create Service of type nodePort 
    -> create Service Account with roles and role bindings to access all the data  
    -> create ConfigMap to feed nginx configuration data
2. CONFIGURE ingress resources 
--> IMPERATIVELY
    k create ingress <name> --rule="host/path=service:port"
    k create ingress add-up --rule="domymath.com/add*=summation:80"
--> DECLARATIVELY
    -> kind: Ingress
    -> spec:
        backend: 
            serviceName: wear-service
            servicePort: 80
    -> spec:
        rules:
        - host: do.my-online-store.com  #you can ignore this line if it's just one hostname
          http:
            paths:
            - path: /wear
              pathType: Prefix
              backend: 
                service:
                    name: wear-service
                    port: 
                        number: 80

# an nginx deployment
apiVersion: apps/v1
kind: Deployment 
metadata:
    name: nginx-ingress-controller
spec:
    replicas: 1
    selector:
        matchLabels:
            name: nginx-ingress
    template:
        metadata:
            labels:
                name: nginx-ingress
            spec:
                containers:
                - name: nginx-ingress-controller #defining the nginx IC
                  image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.21
                args:
                - /nginx-ingress-controller 
                - --configmap=<namespace>/nginx-configuration
                env:
                - name: POD_NAME
                  valueFrom: 
                    fieldRef:
                        fieldPath: metadata.name
                - name: POD_NAMESPACE
                  valueFrom: 
                    fieldRef:
                        fieldPath: metadata.namespace
                ports:
                - name: http
                  containerPort: 80
                - name: https
                  containerPort: 443
                
