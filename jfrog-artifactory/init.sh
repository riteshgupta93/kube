#!/bin/bash

mv artifactory.lic.template artifactory.lic

namespace="artifactory"

if [[ $(kubectl get ns ${namespace}) ]]; then
	kubectl delete ns ${namespace}
fi	

echo Namespace: ${namespace}

kubectl create ns ${namespace}

export MASTER_KEY=$(openssl rand -hex 32)
echo Master Key: ${MASTER_KEY}


kubectl create secret generic my-masterkey-secret -n ${namespace} --from-literal=master-key=${MASTER_KEY}

export JOIN_KEY=$(openssl rand -hex 32)
echo Join Key: ${JOIN_KEY}

kubectl create secret generic my-joinkey-secret -n ${namespace} --from-literal=join-key=${JOIN_KEY}

POSTGRES_PASSWORD="PosTgRes@1to3"

kubectl create secret generic postgres-secret -n ${namespace} --from-literal=password=${POSTGRES_PASSWORD}
echo Postgres Password: ${POSTGRES_PASSWORD}


kubectl create secret generic artifactory-cluster-license -n ${namespace} --from-file=./artifactory.lic
echo Cluster License secret created from file ./artifactory.lic

#--set postgresql.postgresqlPassword=${POSTGRES_PASSWORD}
#--set artifactory.masterKeySecretName=my-masterkey-secret
#--set artifactory.joinKeySecretName=my-joinkey-secret

#helm upgrade --install artifactory --set artifactory.masterKey=${MASTER_KEY} --set artifactory.joinKey=${JOIN_KEY} --namespace artifactory jfrog/artifactory

rm config_keys
echo Master Key: $MASTER_KEY > ./config_keys
echo Join Key: $JOIN_KEY >> ./config_keys
echo Postgres Password: $POSTGRES_PASSWORD >> ./config_keys

kubectl config set-context --current --namespace=$namespace
