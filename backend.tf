terraform {
  backend "s3" {
    bucket         = "tf-best-practicies-785126430074-us-east-1"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
