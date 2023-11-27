# serviceaccount = sa
# 2 types of sa: 
# user accounts [humans]: admin, root, developer, etc.
# service accounts [machines]: prometheus (monitoring), jenkins (automation)

# every NS has an SA automatically created
# when creating a pod, the default SA & token are mounted as a volume to the NS's SA

# create a service account
k create serviceaccount <name> #this creates a token that's used by apps to authenticate
# ^ this commands performs 4 steps:
# (1) creates an object (2) creates an authn bearer token 
# (3) makes the token a secret (4) secret is linked to SA

# get the bearer token
k describe sa <name> #another way to see the bearer token 

# make a call with the token
curl https://10.0.0.0:6443/api --header "Authorization: Bearer <token-from-k-describe-sa>"

# how to add another serviceAccountName to the pod
# and opt out of automounting API credentials for a pod
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  serviceAccountName: build-robot
  automountServiceAccountToken: false

