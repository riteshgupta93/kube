#!/bin/bash

NAMESPACE=artifactory
POSTGRES_PASSWORD="$(kubectl get secret postgres-secret -n ${NAMESPACE} -o jsonpath="{..data.password}" | base64 --decode)"
ADMIN_PASSWORD="$(kubectl get secret admin-secret -n ${NAMESPACE} -o jsonpath="{..data.password}" | base64 --decode)"

#helm upgrade --install artifactory --set artifactory.masterKeySecretName=my-masterkey-secret --set artifactory.joinKeySecretName=my-joinkey-secret --set postgresql.postgresqlPassword=${POSTGRES_PASSWORD} --namespace ${NAMESPACE} jfrog/artifactory

#helm upgrade --install artifactory --set postgresql.postgresqlPassword=${POSTGRES_PASSWORD} --namespace ${NAMESPACE} -f ./values-small-artifactory-ha.yaml jfrog/artifactory-ha

helm upgrade --install artifactory --set postgresql.postgresqlPassword=${POSTGRES_PASSWORD}  --namespace ${NAMESPACE} -f ./values-small-artifactory.yaml jfrog/artifactory


