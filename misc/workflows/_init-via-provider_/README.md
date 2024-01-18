Easy init of Workflows samples dev environment.
Will produce 
 - project
 - null template (for nodes)
 - workflow template (for environment)
 - workflow environment

Will use our [env0 provider](https://registry.terraform.io/providers/env0/env0/latest/docs).

## How to run:
1. load as a simple terraform/tofu environment or template.
2. provide environment variables in env0:
```bash
ENV0_API_KEY="..."
ENV0_API_SECRET="..."
ENV0_API_ENDPOINT=(optional)
// ENV0_ORGANIZATION_ID is not needed because it proveded by env0 on runtime
```
Use PAK (Personal API Key) values.


