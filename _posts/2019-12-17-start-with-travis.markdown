---
layout: post
comments: true
title:  "Start with travis"
date:   2019-12-17 09:00:00 +0200
categories: travis docker
---

## Travis

[Travis CI](https://travis-ci.org/) is a continuous integration service used to
build and test software projects hosted at GitHub.

## Simple repo with travis


Create a github repository with a file `hello_world.py`:

``` python
print("Hello World!")
```

Here we call this repo `simple_travis` 
(see <https://github.com/sbartek/simple_travis>).

In travis CI <https://travis-ci.org/getting_started> add repo by pressing `+` 
(remember about sync accounts).

Next create `.travis.yml` with

``` yaml
language: python
python:
  - 3.6.8
script: 
  - python hello_world.py
```

Then, push to master should trigger running the script `hello_world.py`. You can see it in at the
end of travis' job logs:

``` shell
$ python hello_world.py
Hello World!!!
The command "python hello_world.py" exited with 0.
Done. Your build exited with 0.
```

## Building a docker container and pushing it to docker hub

Here we connect travis to project `flaskhelloworld` build in 
[Docker: Hello World]({% post_url 2019-04-23-docker-hello-world %}).

I assume you have an account on [Docker Hub](https://hub.docker.com/) and you have sync it with
github. Then you have to add a github repo to travis. The in repo's setting 
(More Options -> Settings)
in travis you need to add credentials from Docker Hub 
[Account Settings -> Security -> New Access Token](https://hub.docker.com/settings/security) 

And finally create `.travis.yml` similar to this one:

``` yaml
language: python
python:
  - 3.6.8
services:
  - docker
before_install:
  - docker build --tag $DOCKER_USERNAME/flaskhelloworld .
  - docker images
  - echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  - docker push $DOCKER_USERNAME/flaskhelloworld
script:
  - python test/test_app.py
```


And that's it. See the repo <https://github.com/sbartek/sample_flask_app>.
