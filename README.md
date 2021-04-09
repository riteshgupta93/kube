# Kubenetes CICD with PROW

## create prow cluster on k8s

`kubectl apply -f prow/prow-starter.yaml`


## create jfrog artifactory ha setup on k8s
switch to jfrog-artifactory directory and update the artifactory.lic.template file with the license/s.


`./init.sh`
`./create-ha.sh`

Note: Master key and join key will be saved in the current folder in config_keys file
