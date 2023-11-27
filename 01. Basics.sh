# how to edit in NANO
export KUBE_EDITOR="nano"

# how to get some of the templates
k explain <concept> --recursive | grep <searchTerm> -A3
k explain pods --recursive | grep envFrom -A3 

# how to count objects (namespaces, pods, deploys, etc.)
k get <object> --no-headers | wc -l
k get pods --no-headers | wc -l 

# how to search for something in the output
k <command> -A | grep <search-term>
k get pods -A | grep blue

# how to get inside a pod
k exec -it <pod-name> <command-to-run>
k exec -it my-pod ls /var/run/secrets/*

# how to remove a pod & replace it with a new file
k replace --force -f <name-of-temporary-file>
k replace --force -f pod-definition-1032.yaml

# extract the yaml file
<whatever-command> --dry-run=client -o yaml > filename.yaml
k run hello-world --image=nginx --dry-run=client -o yaml > pod.yaml

# get cluster information: addresses of master and services
k cluster-info

# get all the information of an object
k describe <object> <object-name>
k describe pod hello-pod

# edit the  pod directly
k edit pod pod-name

# get labels of a node
k get nodes node-name --show-labels

# ------------DOCKER STUFF FYI--------
# In the Dockerfile
# 		○ CMD ["bash"] 
# 			it's the command that will run the program 
# 			It could be ["ubuntu"] or ["mysql"]
# 		○ Append the command to docker run command: 
# 			"docker run ubuntu sleep 5"
# 		○ If you always want to run the "sleep 5", mention it in Dockerfile:
# 			As command: CMD sleep 5
# 			As JSON array: CMD ["sleep", "5"]
# 		○ If you want to change the # of seconds it sleeps:
# 			FROM Ubuntu
#           ENTRYPOINT ["sleep"]
# 			CMD ["5"]                            //default value if nothing is provided
# 
#           Command provided:
#           "docker run ubuntu 10"
#           docker run ubuntu + <ENTRYPOINT> + <VARIABLE PROVIDED>

# To get the OS 
cat /etc/*release*