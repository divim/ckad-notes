# Build docker image from Dockerfile
docker build -t <name>:<tag> .
# Run docker image f
docker run -p <host>:<container> <imageName>
docker run -p 80:8080 webapp 
# Publish the image to the Docker registry
docker push divim/custom-app 
# Figure out an image
docker run python:3.6 cat /etc/*release*


# Dockerfile: 
set of "<instruction> <argument>" to form a layered architecture
# -----------------SAMPLE----------
# 1. always starts from FROM
FROM Ubuntu 
# 2. get dependencies
RUN apt-get update 
RUN apt-get install python 
# 3. copy source code from local source to docker container
COPY . /opt/source-code 
# 4. specify ENTRYPOINT
ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run 

