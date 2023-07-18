## What is this?

This is an example of a workflow template with one environment.
In this specific scenario:
- Deployment would start deployment of one null-resource stack `nullService1`

## How to run in env0?

### Prerequisites

This example assumes the template with the following name already exist on your env0 organisation:
- 'null resource'

You can either create it in your organization, or alter `env0.workflow.yml` file to match other existing templates in your env0 organisation

### Defining the template

- In env0, create a new template of type "env0 workflow"
- On the VCS step, pick the repository containing this file, and put `misc/single-environment-workflow` under "env0 Workflow Location"
- Save the template

### Running the template

Now that the template is defined, you can simply run it in any env0 project using the "Create New Environment" button.
Make sure to pick the template defined in the last step
