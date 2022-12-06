#!/bin/bash

set -e

kubectl create configmap trino-cfg -n=bh-dl-query-layer --dry-run=client --from-file=./etc/catalog/adls2.properties --from-file=./etc/catalog/tpcds.properties --from-file=./etc/catalog/tpch.properties --from-file=./etc/config.properties --from-file=./etc/jvm.config --from-file=./etc/log.properties --from-file=./etc/node.properties -o yaml | kubectl apply -n=bh-dl-query-layer -f -
