#!/usr/bin/env bash
set -e

# INSTALLING VAULT
echo "1. Installing vault..."
curl -sL https://releases.hashicorp.com/vault/1.11.1/vault_1.11.1_linux_amd64.zip -o vault1.zip
unzip -o vault1.zip
./vault --version
