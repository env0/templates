Easy init of Workflows samples dev environment.
Will produce 
 - project
 - null template (for nodes)
 - workflow template (for environment)
 - workflow environment

Will use our [env0 provider](https://registry.terraform.io/providers/env0/env0/latest/docs).

## How to run:
1. load as a simple terraform/tofu environment or template.
2. provide environment variables:
```bash
ENV0_API_KEY=""
ENV0_API_SECRET=""
ENV0_ORGANIZATION_ID="41890b8e-f15b-464e-9c9a-81e439f33406"
ENV0_API_ENDPOINT=(optional)
```
Use PAK (Personal API Key) values.


