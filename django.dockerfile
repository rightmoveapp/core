from python:3.7-slim

##^^ this tells docker you don't want to start from scratch. 
## go get the "python 3.7 super basic version (ie slim) image from docker hub, start with that."


## make a directory inside the container called `/app`
RUN mkdir /app

## copy all the files from wherever you ran this dockerfile (so project root is where this should be) into the `/app` directory 
## inside the container
COPY . /app

## update apt-get in the container so you can download current things
RUN apt-get update -y && \

## install python and pip (python's package manager) plus developer tools for python
apt-get install python-pip python-dev build-essential -y

## install every python program in the requirements.txt file
RUN pip3 install -r /app/requirements.txt 

## set it so all docker commands going forward start in the `/app` directory
WORKDIR /app/right_move
EXPOSE 80
## connect port 8000 to the "outside world" of the container (so you can connect via localhost:8000 and don't need to go inside the container)
ENTRYPOINT ["/app/entrypoint.sh"]




