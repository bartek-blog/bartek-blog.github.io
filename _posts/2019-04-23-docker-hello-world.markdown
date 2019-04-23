---
layout: post
comments: true
title:  "Docker: Hello World"
date:   2019-04-23 09:00:00 +0200
categories: docker flask 
---


## Install docker on mac

### Docker
```
brew cask install docker
```

### Virtual Box

```
brew cask install virtualbox
```

### Check versions

```
docker version

docker-compose version


docker-machine --version
```

A standalone Kubernetes server is also included.

```
kubectl version --client
```

### Autocomplete

see <https://docs.docker.com/compose/completion/>

In particular for `.zshrc` with oh-my-zsh:
```
plugins=(... docker docker-compose
)
```

### Test it

```
docker run hello-world
```

## Basic commands



### Run docker container 

This case `nginx` with name `webserver`
```
docker run --detach --publish=80:80 --name=webserver nginx
```


### View containers

Running
```
docker container ls
```
All
```
docker container ls -a
```
### Stop container by name

```
docker container stop webserver
```

### Remove container

```
docker container rm webserver
```

### View images

```
docker image ls
```

### Remove image

by `RESPOSITORY`

```
docker image rm nginx
```

## Docker file: Flask app

First we create a directory `sample_flask_app`. Inside it we will create the following files:
1. `Dockerfile`
2. `hello_world_app.py`
3. `requirements.txt`

### Dockerfile

``` dockerfile
# Use an official Python runtime as a parent image
FROM python:2.7-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]
```

### hello_world_app.py

Create `hello_world_app.py` with the following code:
``` python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Hello world"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
```

### requirements.txt

And finally `requirements.txt`
``` shell
Flask
```

## Build

``` shell
docker build --tag=flaskhelloworld .
```

Check if it is created:

``` shell
docker image ls
```

## Run

Well, as before

``` shell
docker run  --detach --publish=4001:80 --name=flask_hw flaskhelloworld
```

## Test it

Now you can go to `http://localhost:4001` or simply

``` shell
curl http://localhost:4001
```

<https://codingbee.net/docker/install-docker-for-mac-using-homebrew>
<https://docs.docker.com/docker-for-mac/>