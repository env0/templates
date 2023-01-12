#!/bin/bash

cat ~/.terraformrc
echo 'credentials "backend-pr10727.api.dev.env0.com" {' > ~/.terraformrc
echo '  token = "cmp6ZzY5ZTl0d2NsMmF4bjpZXzc1ZDFBV0hVQjhWREE1ajBwUDRMYnpST2FmUjRvXw=="' >> ~/.terraformrc
echo '}' >> ~/.terraformrc
cat ~/.terraformrc

terraform -chdir='./local-run' init

terraform -chdir='./local-run' plan > plan-out.txt

echo "status code: $?"

errors=`grep -c  -w 'error' plan-out.txt`


echo $errors
# deployment_id=${deployment_url##*/}

# echo "deployment ID: $deployment_id##"

# url="https://api-pr10727.dev.env0.com/environments/deployments/$deployment_id"

# curl -g $url --header 'Authorization: Bearer cmp6ZzY5ZTl0d2NsMmF4bjpZXzc1ZDFBV0hVQjhWREE1ajBwUDRMYnpST2FmUjRvXw=='