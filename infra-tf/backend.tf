terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.95.0" 
    }
  }


backend "s3" {
    bucket         = "end-to-end-devsecops11-tf"
    region         = "us-east-1"
    key            = "devsecops-infra/terraform.tfstate"
    dynamodb_table = "end_to_end_devsecops_tf_Lock_State_Files"
    encrypt        = true
  }

}

provider "aws" {
  region  = var.region
}
