#!/bin/bash

docker build -t serveur-nginx -f Dockerfile-nginx .
docker build -t go-access -f Dockerfile-goaccess .

docker volume create nginx-logs

docker run --name nginx-server -p 80:80 -v nginx-logs:/var/log/nginx -it -d serveur-nginx
docker run --name nginx-logs-collector -v nginx-logs:/var/log/nginx -it -d go-access

