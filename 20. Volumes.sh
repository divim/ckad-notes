# Pods are transient in nature

# PVC/VOLUME - YAML configuration
apiVersion: v1
kind: Pod
metadata:
    name: test-volume
spec: 
    containers: 
    - name: test-volume 
      image: nginx 
      volumeMounts: 
      - mountPath: /opt     # data & directory of mount path gets deleted
                            # remains in the hostPath of volume after completion
        name: data-volume
    volumes:                
    - name: data-volume    # YOU DON'T USUALLY DO IT THIS WAY
                            # Drawback: you need to define the volume every time you're spinning a Pod 
      
      hostPath:             # hostPath = directory from the node on which pod is running
        path: /data         # remains on the node after completion
        type: Directory
    - name: mypd            # MAKES CLAIM TO PV THROUGH PVC
      persistentVolumeClaim:
        claimName: myclaim

# PERSISTENT VOLUME to manage storage centrally
--> admin creates persistent volume centrally to be used 
--> user creates PV claims (pvc) to claim a pv to be used 
--> 1:1 relationship between claims and volumes
------> matches properties to match or use labels/selectors (request, accessMode, etc.)
------> pvc will remain in pending state until pv is available


#YAML config
apiVersion: v1
kind: PersistentVolume
metadata:
    name: pv-volume
spec: 
    persistentVolumeReclaimPolicy: Delete   # default option is "Retain"
                                            # another option is "Recycle" to scrub data & make it ready to use again
    accessModes:
    - ReadWriteOnce # other possible values: ReadOnlyMany, ReadWriteMany
    capacity:
        storage: 1Gi
    hostPath: 
        path: /tmp/data 

# PERSISTENT VOLUME CLAIM to make storage to a node
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
    name: pvc-demo 
spec: 
    accessModes:
    - ReadWriteOnce # other possible values: ReadOnlyMany, ReadWriteMany
    capacity:
        storage: 1Gi

# POD ASKING FOR PVC 
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: myclaim

# Deleting pvc
k delete pvc pvc-demo  
# What happens to underlying pv? 
default is set to retain  

