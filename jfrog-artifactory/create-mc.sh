#!/bin/bash

NAMESPACE=artifactory
MC_MASTER_KEY_SECRET=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_MASTER_KEY_SECRET}')
MC_JOIN_KEY_SECRET=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_JOIN_KEY_SECRET}')
JFROG_ROUTER_URL="http://$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_INGRESS_HOST}')"

cp ./values/values-small-mission-control.yaml.template ./values/values-small-mission-control.yaml

sed -i -e "s|MC_MASTER_KEY_SECRET|$MC_MASTER_KEY_SECRET|g" \
       -e "s|MC_JOIN_KEY_SECRET|$MC_JOIN_KEY_SECRET|g" \
       -e "s|JFROG_ROUTER_URL|$JFROG_ROUTER_URL|g" ./values/values-small-mission-control.yaml

helm upgrade --install mission-control  --namespace ${NAMESPACE} -f ./values/values-small-mission-control.yaml jfrog/mission-control
