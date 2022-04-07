# Terragrunt source Template
The root Terragrunt configuration will use a terraform source block to create a null resource by a local module.
The Terragrunt project contain two (unrelated) stage: 
* "simple" which only use the root Terragrunt configuration.
* "with-env-yaml" which also add env0.yaml to delete the .terragrunt-cache folder after TG plan
