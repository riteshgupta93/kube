Prow setup on k8s

# Create an oauth2 token from the github gui for the bot account.

`echo "PUT_TOKEN_HERE" > oauth

kubectl create secret generic oauth --from-file=oauth=oauth
`

# Create an openssl token to be used with the Hook.

` openssl rand -hex 20 > hmac

  kubectl create secret generic hmac --from-file=hmac=hmac
`

# Create all the Prow components.

`
kubectl create -f prow_starter.yaml
`

# update-config

` kubectl create configmap config --from-file=config.yaml=config.yaml --dry-run -o yaml | kubectl replace configmap config -f -
`
# update-plugins

` kubectl create configmap plugins --from-file=plugins.yaml=plugins.yaml --dry-run -o yaml | kubectl replace configmap plugins -f -
`

# update-jobs

` kubectl create configmap job-config --from-file=prow/jobs/ --dry-run -o yaml | kubectl replace configmap job-config -f -
`
