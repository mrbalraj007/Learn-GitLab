terraform {
  backend "s3" {
    bucket       = "cf-templates-shlcjth566j2-us-east-1" # define here the S3 bucket name
    key          = "environment/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true # no need for Dynamodb tabel, AWS has release a new thing.

    # Remove the unsupported retry parameters
  }
}
