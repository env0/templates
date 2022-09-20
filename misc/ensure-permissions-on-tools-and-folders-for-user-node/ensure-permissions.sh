#!/usr/bin/env bash
set -e -x

# list installed apk packages
apk list --installed | sort

# list installed python packages
pip3 list | sort

# from base image
node --version
npm --version
yarn --version

#from alpine repos
bash --version
git --version
python3 --version
pip3 --version
jq --version
openssl version
ssh -V
curl --version

# other
aws --version
awsv2 --version
gcloud --version
az --version
kubectl version --client
tfenv --version
terraform --version
tgenv --version
terratag --help
pwsh -v
infracost --version

# Check write permissions
touch /opt/test
rm /opt/test
touch /tmp/test
rm /tmp/test
touch /home/node/test
rm /home/node/test
mkdir -p /home/node/.cache
python3 -m venv -h

# Check packages install
pip install --user ansible
ansible --version

apk update
apk add rsync
rsync --version

node install -g @env0/cli
env0 help