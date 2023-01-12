# env0 Custom Flow: Dynamic Backend

This _project_ [custom flow](https://docs.env0.com/docs/custom-flows) facilitates dynamically generated backend configurations, enabling a one-to-many posture for a Terraform codebase and mitigates all discipline dependency surrounding workspace naming schemas, as workspaces are not used with this kit.

Features:

- Normalization of env0 "Environment"/stack names for use in the backend key/prefix.
- Dynamically constructed s3 bucket name. IE: '\<corp\>-\<product-line\>-tf-state-\<region\>'.
- Dynamically constructed key/prefix. IE: '\<workload env\>/\<stack name\>/state'
- Dependency Checks.
- Backend key/prefix collision prevention.
- Disabling of env0 default workflow handling.
- Garbage collection upon "Environment"/stack destroy action.

This will be of immediate value to anyone familiar with the infamous "Variables may not be used here." error thrown when attempting to use a variable in the backend configuration.

One point of particular value is _how_ this enables permission policies to be formed. For example, an s3 bucket policy might permit access access to specific workload environment states based on prefix, while restricting others. You can also create two env0 projects for each workload env, one for C&C where sensitive state data might reside, and one for less sensitive stacks. For example, you might run an iam user module in a project called dev-cmd, and a vpc module in dev, allowing all to see the outputs for the vpc, as they're typically required as data sources for other modules.

> Note specifically that adjusting this kit to work with other remote backends, or as stack specific kit should be trivial.

Remember, this is only an example. While it will work out of the box as described, feel free to adjust it as necessary to suit your particular use case.

## Usage

This example directory structure is setup to mimic what an actual Terraform repository might look like, including a directory for the env0 custom flow, and a modules directory. Yes, a single _output_ is a valid module, and will suffice to demonstrate this kit.

1. Include the custom-flow code in your repo as described below.
1. Add the env0 project level environment variables as described below.
1. Configure the custom flow as a project policy as described below.
1. Run the project.

### Dependencies

Assuming you have a project setup with the necessary AWS credentials to use an s3 backend, the remaining dependencies are as follows:

#### Code Repository

Add this example code to the repository containing your Terraform modules.

Suggested location:

- \<repo\>/env0/custom_flows/dynamic_backend/

> NOTE: If another path is used, adjust 'env0.yaml' and 'dynamic_backend_configurator.sh' accordingly.

#### Project Environment Variables

The following environment variables MUST be set at the [project](https://docs.env0.com/docs/variables#variables-and-scopes-in-env0) level.

- ENV0_SKIP_WORKSPACE
  - Must be set to 'true'
- BACKEND_S3_BUCKET
  - The s3 bucket to use.
  - The [credential](https://docs.env0.com/docs/connect-your-cloud-account) configured for the project must have appropriate permissions.
- PRODUCT_GROUP_STUB
  - The OU or product group initials. This will be used to construct the key/prefix.
- WORKLOAD_ENVIRONMENT
  - The workload environment, such as dev, qa, etc. This will be used to construct the key/prefix.

#### Project Policy: Custom Flow

Configure the project level custom flow as described [here](https://docs.env0.com/docs/project-level-custom-flow).

Note specifically that env0 _requires_ a specific yaml file to be defined, and not a directory.

> Assuming this custom flow was included in the code repository as described [here](#code-repository), the 'ENV0_ROOT_DIR' envar will ensure relativistic sanity between the custom flow working directory and the dependent scripts.
