provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name           = "windows_ec2"
  instance_type  = var.instance_type
  ami            = var.ami
  key_name       = var.key_name

  ebs_block_device = [
    {
      device_name = "/dev/sdh"
      volume_type = "gp2"
      volume_size = var.ebs_volume_size
    }
  ]

  tags = {
    Name = "Windows-EC2"
  }
}
