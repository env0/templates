## What is this?

This is an example of a workflow template. In here, you define all environments and deployments that take part in the workflow.
This allows you to create stack dependencies.

In this specific scenario: 
- Initial deployment would start deployment of two stacks: `rootService1` and `rootService2`
- Once both "root" services finish deploying, two other stacks start deployment - `middleService1` and `middleService2`
- Once `middleService1` finishes, it triggers `finalService` stack deployment
- Once all above stacks have fully deployed, the deployment is done

## How to run in env0?

### Prerequisites

This example assumes the templates with the following names already exist on your env0 organisation:
- 'hello world'
- 'private github https'
- 'S3 bucket with TF 13'
- 'Terragrunt null resource'
- 'GitHub Integration Test'

You can either create them in your organization, or alter `env0.workflow.yml` file to match other existing templates in your env0 organisation

### Defining the template

- In env0, create a new template of type "env0 workflow"
- On the VCS step, pick the repository containing this file, and put `misc/workflow-environment` under "env0 Workflow Location"
- Save the template

### Running the template

Now that the template is defined, you can simply run it in any env0 project using the "Create New Environment" button. 
Make sure to pick the template defined in the last step
