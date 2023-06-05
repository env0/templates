#!/usr/bin/env bash
set -e

aws eks --region=us-east-1 update-kubeconfig --name $TF_VAR_cluster_name

VAULT_HOST=$(kubectl get service self-hosted-vault-ui -n self-hosted-vault -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "Vault can be reached from http://$VAULT_HOST:8200"
