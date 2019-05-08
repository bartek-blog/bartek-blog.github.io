<https://github.com/jupyter/docker-stacks>

``` shell

docker run -v `pwd`:/home/jovyan/work  -p 8998:8888 jupyter/pyspark-notebook
```

``` shell
docker ps 
docker exec -it <container name> /bin/bash
```
