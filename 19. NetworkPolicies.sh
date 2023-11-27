# If an ingress policy is allowed, egress is allowed automatically

# YAML sample:
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
    name: db-policy
spec:
    podSelector:
        matchLabels:
            role: db
    policyTypes:
    - Ingress 
    ingress:
    - from:         # "to:" in the case Egress
        - podSelector:
            matchLabels:
                name: api-prod 
        - ipBlock:
            cidr: 192.x.x.x/32
       - ports:
         - protocol: TCP
           port: 3306