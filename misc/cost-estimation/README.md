# Cost estimations based on Infracost
This is a sample repository to get cost estimation on the env0 platform.

## How to use
1. Create an [API key for infracost](https://www.infracost.io/docs/integrations/environment_variables#infracost_api_key) so we can set it up as an environment variable.
2. Create a new template in the env0 platform.
3. In the temlpate add `INFRACOST_API_KEY` environment variable and the value should be the key you have created in step 1. (You can make it a sensetive variable)
4. Add an AWS API key and secret or use the [AWS assume role mechanism](https://docs.env0.com/docs/connect-your-cloud-account#using-aws-assume-role)
5. Run a new environment.
6. You should be able to see in the `After: Terraform Plan` phase the results of both the `breackdown` and the `diff` (See [this](https://www.infracost.io/docs/multi_project/report) for more info)

### Breackdown command
![image](https://user-images.githubusercontent.com/46656490/114556063-ff64d300-9c70-11eb-9417-bd7f6b89cf77.png)

### Diff command
![image](https://user-images.githubusercontent.com/46656490/114556118-0e4b8580-9c71-11eb-9454-ea3afeeb8aee.png)
