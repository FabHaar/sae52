#!/bin/bash

docker build -t serveur-nginx -f Dockerfile-nginx .
docker build -t go-access -f Dockerfile-goaccess .

docker volume create nginx-logs

docker run --name nginx-server -p 80:80 -v nginx-logs:/var/log/nginx -d serveur-nginx

docker run --name logs-collector -v nginx-logs:/var/log/nginx -d -it go-access

docker exec -it logs-collector bash -c "goaccess -f /var/log/nginx/access.log"
