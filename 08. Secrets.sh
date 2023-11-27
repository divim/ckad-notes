# Very similar to ConfigMaps - 2 steps INVOLVED 

# Step 1: Create a secret 
# # 1.1: Imperatively
k create secret generic <secret-name> --from-literal=<key>=<value> \
                                        --from-literal=key=<value>
k create secret generic creds --from-file=secrets.properties
# # 1.2: Declaratively
# # # 1.2.1: Encode/decode
echo -n 'word' | base64
echo -n 'word' | base64 --decode 
# # # 1.2.2: Use that in your file
apiVersion: v1
kind: secret
metadata:
    name: app-secret        
data: 
    DB_USER: cMdSf==         # echo -n 'mysql' | base64
    DB_PASSWORD: JdskjdsY0   # echo -n 'password' | base64


# Step 2: Inject into a pod
spec:
    env:
        # Define the environment variable
        - name: SECRET_USERNAME
          valueFrom:
            secretKeyRef:
                name: mysecret
                key: SECRET_USERNAME
                optional: false

    