# 1. Add the Superset helm repository 
    # helm repo add superset https://apache.github.io/superset
# 2. View charts in repo
    # helm search repo superset

# helm repo add bitnami https://charts.bitnami.com/bitnami
# redis password: YsuLyj4gHH% 
# export REDIS_PASSWORD=$(kubectl get secret --namespace default redis -o jsonpath="{.data.redis-password}" | base64 -d)
helm install redis bitnami/redis

helm install bh-postgresql bitnami/postgresql  
# postgresql password: EkcO08OKZ2
# export POSTGRES_PASSWORD=$(kubectl get secret --namespace default bh-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

helm upgrade --install --values bh-superset-qa-values.yaml superset superset/superset

kubectl run --namespace default redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.0.5-debian-11-r15 --command -- sleep infinity
kubectl exec --tty -i redis-client \
   --namespace default -- bash

kubectl run bh-postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:15.1.0-debian-11-r0 --env="PGPASSWORD=EkcO08OKZ2" \
      --command -- psql --host bh-postgresql -U postgres -d postgres -p 5432

CREATE USER superset WITH CREATEDB PASSWORD 'BigHaat@2022'
CREATE DATABASE supersetdb;



kubectl port-forward --namespace default svc/redis-master 6379:6379 &
    REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p 6379
 kubectl run --namespace default redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.0.5-debian-11-r15 --command -- sleep infinity