resource "null_resource" "null1" {
}

terraform {
    backend "s3" {
        bucket = "alon-noga-temp-bucket"
        key    = "tf-state"
        region = "us-east-1"
    }
}
