HELM = Treat K8s apps as apps as opposed to a bunch of objects 
CHART = Helm package containing all resource def inside a cluster 
REPO = place where charts can be collected & shared 
RELEASE = instance of a chart running in a cluster 

Chart: pre-configured set of k8s resources
Release: chart deployed to k8s
Repo: publicly available charts 

# You configure the variables for the size of your app in a "values.yaml" file

# install helm on linux system
sudo snap install helm --classic 
pkg install helm 

# install a package
helm install wordpress [optional more parameters]
# upgrade a package
helm upgrade wordress ..
# rollback a version
helm rollback wordpress ..
# uninstall a version
helm uninstall wordpress ..

# Step #1 - find the chart
# 1.1: search for a helm chart
helm search hub wordpress 
# 1.2: add repo 
helm repo add bitnami https://charts.bitnami.com/bitnami
# 1.3: search repo
helm search repo wordpress 
# 1.4: list repo
helm repo list 
# 1.5: download a repo
helm pull --untar bitnami/apache

# HELM CHART = TEMPLATE + VALUES.YAML FILE + CHART.YAML FILE
# Part 1 = Template
apiVersion: v1
kind: Pod 
metadata:
    name: pod-def 
spec:
    containers: 
    -   name: {{ .Values.Pod-Name }}
        image: {{ .Values.Pod-Image }}

# Part 2 = values.yaml 
Pod-Name: wordpress 
Pod-Image: wordpress:4.8 

# Part 3 = chart.yaml ---> details about the helm chart
apiVersion: v2 
name: Wordpress 
version: 9.0.3
description: something
keywords:
- wordpress
- http
- web 
home: http://www.wordpress.com
sources:
- https://github.com/bitname/bitnami-docker


