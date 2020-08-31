## Description
This is a simple example on how to fetch `pingdom` terraform community provider using [env0 Custom Flows](https://docs.env0.com/docs/custom-flows) on **terraform v11 or v12**.
> Note: For terraform v13 please refer to [terraform's official documentation](https://www.terraform.io/upgrade-guides/0-13.html#explicit-provider-source-locations) on how to specify community providers.

## Steps
What we basically do in `env0.yml` file is:
1. Create the relevant `terraform.d` folder under the user's home folder (env0's runtime uses a dockerized `alpine` image, hence `os_arch` is `linux_amd64`).
2. Download the static artifact file of the `pingdom` community provider from github.
3. Allow execution permissions for the file so `terraform` can use it.

> Note: Please pay attention that custom flow needs to be done before `terraform init` and in both `deploy` and `destroy` actions.
