# how to view enabled admission controllers
kube-apiserver -h | grep enable-admission-plugins 

# how to execute admission controllers
k exec kube-apiserver-controlplane -n kube-system -- kube-apiserver -h | grep enable-admission-plugins 

# 2 types of admission controllers
1) Mutating admission controllers
change or mutate the object
2) Validating admission controllers
validate a request (allow/deny) 

For external admission controllers, you have:
1) MutatingAdmissionWebhook
2) ValidatingAdmissionWebhook
These run on a server (can be in or out of the cluster)

# Steps to use an external webhook admission controller:
1) Deploy webhook server: 
-> must mutate & validate API objects 
2) Configuring admission webhook 
-> must host it on a server or containerize and deploy it
-> if container, needs to have a service 
# YAML file 
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: "pod-policy.example.com"
webhooks:
- name: "pod-policy.example.com"
  rules:
  - apiGroups:   [""]
    apiVersions: ["v1"]
    operations:  ["CREATE"]
    resources:   ["pods"]
    scope:       "Namespaced"
  clientConfig:
    service:
      namespace: "example-namespace"
      name: "example-service"
      # url: if it's not on the cluster itself
    caBundle: <CA_BUNDLE>
  admissionReviewVersions: ["v1"]
  sideEffects: None
  timeoutSeconds: 5

