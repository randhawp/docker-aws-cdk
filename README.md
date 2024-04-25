# docker-aws-cdk
setup portable / non-polluting  execution enviornment for aws cdk projects

## Steps
Edit the included Dockerfile file as required (versions etc)

## build
```
docker build -t <name> .  e.g docker build -t randhawp/cdk:v1
```
## run the docker image
```
docker run -it -v ~/projects:/home/puneet/projects/ -p 3000:3000 randhawp/cdk:v1 /bin/bash   (you can change the folders later at exec time)
```
## find the container id
```
docker ps
```
## creating a cdk project
go to the dir where the cdk project is to be built and run
```
docker exec -w /home/puneet/projects/cdk/hello-cdk <running cdk docker container id> cdk init app --language typescript  (-w does the trick of changing to empty folder for cdk init)
```





