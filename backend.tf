terraform {
  backend "s3" {
    bucket         = "terraform-state-ze98u"
    key            = "global/s3/PaulCAZALS/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
