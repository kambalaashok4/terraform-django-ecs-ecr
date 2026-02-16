 ##s3 backend configuration for Terraform state management
 
 terraform {
      backend "s3" {
        bucket         = "bucketname"
        key            = "envs/prod/terraform.tfstate"
        region         = "us-east-1"
        encrypt        = true
        dynamodb_table = "terraform-locks" # optional but recommended
      }
    }


