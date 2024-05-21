import * as pulumiNull from "@pulumi/null";

// Create an AWS resource (S3 Bucket)
const nullResource = new pulumiNull.Resource("my-null-resource", {});

// Export the name of the bucket
export const nullResourceId = nullResource.id;
