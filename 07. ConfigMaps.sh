# Template of configMap: 
spec:
  containers:
    - name: demo
      image: alpine
      env:
        # Define the environment variable
        - name: #xyz
          valueFrom:
            configMapKeyRef:
              name: #name           # The ConfigMap this value comes from.
              key: #key             # The key to fetch.

# TWO STEPS INVOLVED

# STEP 1: Create the ConfigMap
################## Sample File: config.properties ##################
APP_COLOR: blue
APP_MODE: prod 

# # 1.1: Create imperatively (k create ...)
# # # 1.1.1: Directly putting key-values
k create configmap <name> --from-literal=<key>=<value>
k create configmap app-config \
                    --from-literal=APP_COLOR=blue \
                    --from-literal=APP_MODE=prod
# # # 1.1.2: Create through file path
k create configmap <name> --from-file=config.properties
k create configmap app-config --from-file=config.properties

# # 1.2: Create declaratively (YAML)
apiVersion: v1
kind: ConfigMap
metadata:
  name: game-config
  namespace: default
data:
  APP_COLOR: blue
  APP_MODE: prod
  #---or if you wanna define properties in configure-pod-container/configmap/---
  game.properties: |
    enemies=aliens
    lives=3
    enemies.cheat=true
    enemies.cheat.level=noGoodRotten
    secret.code.passphrase=UUDDLRLRBABAS
    secret.code.allowed=true
    secret.code.lives=30   

# STEP 2: Inject it into the pods
spec:
  containers:
    - name: demo
      image: alpine
      env:
        # Define the environment variable
        - name: app-color
          valueFrom:
            configMapKeyRef:
              name: app-config           # The ConfigMap this value comes from.
              key: APP_COLOR             # The key to fetch.




