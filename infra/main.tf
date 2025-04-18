resource "aws_key_pair" "logger_key" {
  public_key = file(var.public_key_path)
  key_name = var.key_name
}

resource "aws_security_group" "logger_sg" {
  name = "logger-sg"
  description = "Allow SSh and app port"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # open for ssh
  }

  ingress {
    from_port = var.app_port
    to_port = var.app_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #open to app port
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "logger_ec2" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = var.instance_type
  key_name = aws_key_pair.logger_key.key_name
  vpc_security_group_ids = [aws_security_group.logger_sg.id]

  tags = {
    Name = "LoggerAppEC2"
  }
}