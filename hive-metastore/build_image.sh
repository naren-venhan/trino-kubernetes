#!/bin/bash

set -e

REPONAME=narenbighaat/hive-metastore
TAG=3.0.5

docker build -t $TAG . --platform=linux/amd64 

docker login -u narenbighaat -p BigHaat@2022 docker.io

# Tag and push to the public docker repository.
docker tag $TAG $REPONAME:$TAG
docker push $REPONAME:$TAG

# --from-file=core-site.xml
# Update configmaps
kubectl create configmap metastore-cfg --dry-run=client -n=bh-dl-query-layer --from-file=./metastore-site.xml --from-file=./scripts/entrypoint.sh -o yaml | kubectl apply -n=bh-dl-query-layer -f -

# kubectl describe configmaps metastore-cfg
