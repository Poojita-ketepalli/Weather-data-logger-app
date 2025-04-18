variable "aws_region" {
  description = "aws region to deploy"
  default = "ap-south-1"
}
variable "instance_type"{
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair to use for ssh"
}

variable "public_key_path"{
  description = "Path to your public ssh key"
}

variable "app_port"{
  default = 2305
}