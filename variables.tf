variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "ami" {
  description = "Microsoft Windows Server 2022 Core Base 64-bit"
  type        = string
  default = "ami-0a72c1cec9779f01a" 
}

variable "instance_type" {
  description = "machine instance type"
  default     = "t2.micro"
}

variable "ebs_volume_size" {
  description = "Size of the attached EBS volume in GB"
  default     = 20
}

variable "key_name" {
  description = "The name of the key pair to use for access to the machine"
  type        = string
  default     = "my-default-key"
}
