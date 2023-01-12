#!/usr/bin/env bash

# This script records the ENV0_PROJECT_ID and ENV0_ENVIRONMENT_ID
# to the backend in order to mitigate stack collisions.

# This approach is desirable above simply naming the state file the environment id
# because we WANT to identify collisions, rather than have potentially
# orphaned state files in s3.

echo "INFO: Check for existing ID file..."
ENV0_ENVIRONMENT_NAME_NORMALIZED=${ENV0_ENVIRONMENT_NAME// /_}
ENV0_ENVIRONMENT_NAME_NORMALIZED=${ENV0_ENVIRONMENT_NAME_NORMALIZED//[^a-zA-Z0-9-_]/}
ENV0_ENVIRONMENT_NAME_NORMALIZED=${ENV0_ENVIRONMENT_NAME_NORMALIZED,,}

BACKEND_S3_PREFIX="${PRODUCT_GROUP_STUB,,}/${WORKLOAD_ENVIRONMENT,,}/${ENV0_ENVIRONMENT_NAME_NORMALIZED}"

ID="${ENV0_PROJECT_ID}_${ENV0_ENVIRONMENT_ID}"

echo "INFO: Creating local id file..."
echo "$ID" > id
echo "INFO: Checking for remote id file..."
if aws s3 cp "s3://${BACKEND_S3_BUCKET}/${BACKEND_S3_PREFIX}/id" id_remote; then
  echo -e "\e[01;30;107mNOTICE\e[0m: Remote id file exists!"
  echo "INFO: Comparing ids..."
  if [[ $(cat id) == $(cat id_remote) ]]; then
    echo "INFO: ids match. Continuing."
  else
    PROJECT_ID=$(awk -F_ '{print $1}' id_remote)
    ENVIRONMENT_ID=$(awk -F_ '{print $2}' id_remote)
    echo -e "\e[01;31mFATAL\e[0m: Backend key/prefix collision detected! Ids DO NOT match! Quitting..."
    echo "INFO: This can happen if a stack/environment is marked as inactive, rather than deleted, and then re-created."
    echo "      Check the following for details on the original stack/environment:"
    echo "          Project    : https://app.env0.com/p/${PROJECT_ID}/environments"
    echo "          Environment: https://app.env0.com/p/${PROJECT_ID}/environments/${ENVIRONMENT_ID}"
    exit 1
  fi
else
  echo "INFO: No remote id file found."
  echo "INFO: Uploading id file to s3://${BACKEND_S3_BUCKET}/${BACKEND_S3_PREFIX}..."
  aws s3 cp id "s3://${BACKEND_S3_BUCKET}/${BACKEND_S3_PREFIX}/"
fi
