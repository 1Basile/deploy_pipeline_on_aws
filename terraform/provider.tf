provider "aws" {
    region = "eu-central-1"
    shared_credentials_file = "tf_user/.aws/cred"

    # setting default tags for all resource
    default_tags {
      tags = local.default_tags
    }
}
