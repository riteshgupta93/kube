#!/bin/bash

NAMESPACE="artifactory"
ARTIFACTORY_MASTER_KEY_SECRET="my-masterkey-secret"
ARTIFACTORY_JOIN_KEY_SECRET="my-joinkey-secret"
ARTIFACTORY_LICENSE_SECRET="artifactory-cluster-license"
ARTIFACTORY_LICENSE_KEY="artifactory.lic"
ARTIFACTORY_ADMIN_SECRET="admin-secret"
ARTIFACTORY_ADMIN_KEY="password"
# Refer ./rds-artifactory.yaml 
ARTIFACTORY_DB_SECRET="rds-artifactory"
ARTIFACTORY_DB_USER_KEY="db-user"
ARTIFACTORY_DB_PASSWORD_KEY="db-password"
ARTIFACTORY_DB_URL_KEY="db-url"
ARTIFACTORY_INGRESS_HOST="jfrog.artifactory.local"
ADMIN_DATA="admin@*=Admin@1234"

if [ ! -f ./artifactory.lic ]; then
cp artifactory.lic.template artifactory.lic
fi

if [[ $(kubectl get ns ${NAMESPACE}) ]]; then
	kubectl delete ns ${NAMESPACE}
fi	

echo Namespace: ${NAMESPACE}

kubectl create ns ${NAMESPACE}

export MASTER_KEY=$(openssl rand -hex 32)
echo Master Key: ${MASTER_KEY}


kubectl create secret generic ${ARTIFACTORY_MASTER_KEY_SECRET} -n ${NAMESPACE} --from-literal=master-key=${MASTER_KEY}

export JOIN_KEY=$(openssl rand -hex 32)
echo Join Key: ${JOIN_KEY}

kubectl create secret generic ${ARTIFACTORY_JOIN_KEY_SECRET} -n ${NAMESPACE} --from-literal=join-key=${JOIN_KEY}


kubectl create secret generic ${ARTIFACTORY_ADMIN_SECRET} -n ${NAMESPACE} --from-literal=${ARTIFACTORY_ADMIN_KEY}=${ADMIN_DATA}
echo ADMIN CREDS: ${ADMIN_DATA}

kubectl create secret generic ${ARTIFACTORY_LICENSE_SECRET} -n ${NAMESPACE} --from-file=./${ARTIFACTORY_LICENSE_KEY}
echo Cluster License secret created from file ./artifactory.lic

kubectl apply -f ./rds-artifactory.yaml -n ${NAMESPACE}

echo Refer jfrog-configmap for all the secrets reference

kubectl create configmap -n ${NAMESPACE} jfrog-configmap --from-literal=ARTIFACTORY_MASTER_KEY_SECRET=${ARTIFACTORY_MASTER_KEY_SECRET} \
	--from-literal=ARTIFACTORY_JOIN_KEY_SECRET=${ARTIFACTORY_JOIN_KEY_SECRET} \
	--from-literal=ARTIFACTORY_LICENSE_SECRET=${ARTIFACTORY_LICENSE_SECRET} \
	--from-literal=ARTIFACTORY_LICENSE_KEY=${ARTIFACTORY_LICENSE_KEY} \
	--from-literal=ARTIFACTORY_ADMIN_SECRET=${ARTIFACTORY_ADMIN_SECRET} \
	--from-literal=ARTIFACTORY_ADMIN_KEY=${ARTIFACTORY_ADMIN_KEY} \
	--from-literal=ARTIFACTORY_DB_SECRET=${ARTIFACTORY_DB_SECRET} \
	--from-literal=ARTIFACTORY_DB_USER_KEY=${ARTIFACTORY_DB_USER_KEY} \
	--from-literal=ARTIFACTORY_DB_PASSWORD_KEY=${ARTIFACTORY_DB_PASSWORD_KEY} \
	--from-literal=ARTIFACTORY_DB_URL_KEY=${ARTIFACTORY_DB_URL_KEY} \
        --from-literal=ARTIFACTORY_INGRESS_HOST=${ARTIFACTORY_INGRESS_HOST}

rm config_keys
echo Master Key: $MASTER_KEY > ./config_keys
echo Join Key: $JOIN_KEY >> ./config_keys

kubectl config set-context --current --namespace=$NAMESPACE
