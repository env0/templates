### Validate Assume Role

This template validates that an assumed AWS IAM role has been assumed correctly by env0.
It will validate that the assumed identity ARN matches the regex given in the environment variable `EXPECTED_ARN`
