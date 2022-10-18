terraform {
    backend "s3" {
        bucket = "foo-automation-us-east-2"
        key    = "state"
        region = "us-east-2"
    }
}
