#!/bin/bash

NAMESPACE=artifactory
ARTIFACTORY_MASTER_KEY_SECRET=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_MASTER_KEY_SECRET}')
ARTIFACTORY_JOIN_KEY_SECRET=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_JOIN_KEY_SECRET}')
ARTIFACTORY_LICENSE_SECRET=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_LICENSE_SECRET}')
ARTIFACTORY_LICENSE_KEY=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_LICENSE_KEY}')
ARTIFACTORY_ADMIN_SECRET=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_ADMIN_SECRET}')
ARTIFACTORY_ADMIN_KEY=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_ADMIN_KEY}')
ARTIFACTORY_DB_SECRET=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_DB_SECRET}')
ARTIFACTORY_DB_USER_KEY=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_DB_USER_KEY}')
ARTIFACTORY_DB_PASSWORD_KEY=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_DB_PASSWORD_KEY}')
ARTIFACTORY_DB_URL_KEY=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_DB_URL_KEY}')
ARTIFACTORY_INGRESS_HOST=$(kubectl get configmap jfrog-configmap -o jsonpath='{.data.ARTIFACTORY_INGRESS_HOST}')

cp ./values/values-small-artifactory.yaml.template ./values/values-small-artifactory.yaml

sed -i -e "s|ARTIFACTORY_MASTER_KEY_SECRET|$ARTIFACTORY_MASTER_KEY_SECRET|g" \
       -e "s|ARTIFACTORY_JOIN_KEY_SECRET|$ARTIFACTORY_JOIN_KEY_SECRET|g" \
       -e "s|ARTIFACTORY_LICENSE_SECRET|$ARTIFACTORY_LICENSE_SECRET|g" \
       -e "s|ARTIFACTORY_LICENSE_KEY|$ARTIFACTORY_LICENSE_KEY|g" \
       -e "s|ARTIFACTORY_ADMIN_SECRET|$ARTIFACTORY_ADMIN_SECRET|g" \
       -e "s|ARTIFACTORY_ADMIN_KEY|$ARTIFACTORY_ADMIN_KEY|g" \
       -e "s|ARTIFACTORY_DB_SECRET|$ARTIFACTORY_DB_SECRET|g" \
       -e "s|ARTIFACTORY_DB_USER_KEY|$ARTIFACTORY_DB_USER_KEY|g" \
       -e "s|ARTIFACTORY_DB_PASSWORD_KEY|$ARTIFACTORY_DB_PASSWORD_KEY|g" \
       -e "s|ARTIFACTORY_DB_URL_KEY|$ARTIFACTORY_DB_URL_KEY|g" \
       -e "s|ARTIFACTORY_INGRESS_HOST|$ARTIFACTORY_INGRESS_HOST|g" ./values/values-small-artifactory.yaml


helm upgrade --install artifactory --namespace ${NAMESPACE} -f ./values/values-small-artifactory.yaml jfrog/artifactory
