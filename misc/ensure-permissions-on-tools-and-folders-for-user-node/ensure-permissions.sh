#!/usr/bin/env bash
set -e

# Check tools permissions
node --version
npm --version
yarn --version
git --version
python2 --version
python3 --version
pip2 --version
pip3 --version
aws --version
gcloud --version
az --version
kubectl version --client
tfenv --version
terraform --version
tgenv --version
terratag --help
jq --version
pwsh -v
curl --version
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
pip install --user j2cli
