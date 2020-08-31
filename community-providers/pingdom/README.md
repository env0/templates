## Description
This is a simple example on how to fetch `pingdom` terraform community provider using [env0 Custom Flows](https://docs.env0.com/docs/custom-flows).

What we basically do in `env0.yml` file is:
1. Create the relevant `terraform.d` folder under the user's home folder (env0's runtime uses a dockerized `alpine` image, hence `os_arch` is `linux_amd64`).
2. Download the static artifact file of the `pingdom` community provider from github.
3. Allow execution permissions for the file so `terraform` can use it.