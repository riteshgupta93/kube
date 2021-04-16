#!/bin/bash

NAMESPACE=artifactory
POSTGRES_PASSWORD="$(kubectl get secret postgres-secret -n ${NAMESPACE} -o jsonpath="{..data.password}" | base64 --decode)"

#jfrogUrl="$(kubectl get svc --namespace ${NAMESPACE} artifactory-artifactory-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"

jfrogUrl="http://192.168.49.2:$(kubectl get svc --namespace ${NAMESPACE} artifactory-artifactory-nginx -o jsonpath='{.spec.ports[0].nodePort}')"

echo $jfrogUrl

helm upgrade --install mission-control --set postgresql.postgresqlPassword=${POSTGRES_PASSWORD} --namespace artifactory -f ./values-small-mission-control.yaml jfrog/mission-control

#helm upgrade --install mission-control --set missionControl.joinKeySecretName=my-joinkey-secret --set missionControl.jfrogUrl="http://192.168.49.2:32174" --namespace artifactory -f ./values-small-mission-control.yaml jfrog/mission-control

