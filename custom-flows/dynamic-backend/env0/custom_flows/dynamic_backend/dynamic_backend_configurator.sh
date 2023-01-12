#!/usr/bin/env bash

# Generate backend.tf

# Generally you can't override ENVO_ vars. Including 'ENV0_WORKSPACE_NAME'.
# What you can do is disable workspace handling entirely.
# REF: https://docs.env0.com/docs/additional-controls#skip-workspace-commands
# With env0 default workspace handling disabled, custom handling for the state location can be implemented.

echo "INFO: Normalize ENV0_ENVIRONMENT_NAME..."
ENV0_ENVIRONMENT_NAME_NORMALIZED=${ENV0_ENVIRONMENT_NAME// /_}
ENV0_ENVIRONMENT_NAME_NORMALIZED=${ENV0_ENVIRONMENT_NAME_NORMALIZED//[^a-zA-Z0-9-_]/}
ENV0_ENVIRONMENT_NAME_NORMALIZED=${ENV0_ENVIRONMENT_NAME_NORMALIZED,,}

echo "INFO: Configure backend state prefix/key..."
BACKEND_S3_PREFIX="${PRODUCT_GROUP_STUB,,}\/${WORKLOAD_ENVIRONMENT,,}\/${ENV0_ENVIRONMENT_NAME_NORMALIZED}"
BACKEND_STATE_FILE="state"
BACKEND_KEY="${BACKEND_S3_PREFIX}\/${BACKEND_STATE_FILE}"

echo "INFO: Generate backend.tf..."
sed \
  -e "s/BACKEND_S3_BUCKET/$BACKEND_S3_BUCKET/g" \
  -e "s/BACKEND_KEY/$BACKEND_KEY/g" \
  "$ENV0_ROOT_DIR/env0/custom_flows/dynamic_backend/dynamic_backend.template" > backend.tf
