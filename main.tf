resource "aws_key_pair" "terraform_best_practices_demo" {
  key_name   = format("%s-terraform-best-practices-demo-key", terraform.workspace)
  public_key = file("~/.ssh/tf_id_rsa.pub")
}

resource "aws_instance" "instance_1" {
  ami           = var.instance_1_ami
  instance_type = var.instance_1_type
  tags = {
    Name = format("%s-%s", terraform.workspace, var.instance_1_name)
  }
  key_name = format("%s", aws_key_pair.terraform_best_practices_demo.key_name)
}

resource "aws_instance" "instance_2" {
  ami           = var.instance_2_ami
  instance_type = var.instance_2_type
  tags = {
    Name = format("%s-%s", terraform.workspace, var.instance_2_name)
  }
  provisioner "local-exec" {
    command    = "echo The IP address of the Server is ${self.private_ip}"
    on_failure = continue
  }
  key_name = format("%s", aws_key_pair.terraform_best_practices_demo.key_name)
}

module "website_s3_bucket_1" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_prefix = format("%s-%s", terraform.workspace, var.website_s3_bucket_1_prefix)

  tags = {
    Terraform   = var.terraform
    Environment = var.environment
  }
}

module "website_s3_bucket_2" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_prefix = format("%s-%s", terraform.workspace, var.website_s3_bucket_2_prefix)

  tags = {
    Terraform   = var.terraform
    Environment = var.environment
  }
}
