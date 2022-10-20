
resource "tls_private_key" "my-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ssh-key"
  public_key = tls_private_key.my-key.public_key_openssh
}

resource "aws_iam_role" "role" {
  name               = "ec2-iam-role"
  assume_role_policy = file("${path.module}/ec2.json")
}


resource "aws_iam_instance_profile" "ec2-profile" {
  name = "ec2-role-profile"
  role = aws_iam_role.role.name
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "selected" {
  id = "subnet-04322a9df4345b339"# replace for your subnet
}

resource "aws_security_group" "ec2-machine-sec-group" {
  name = "ec2-sg"

  description = "SG (terraform-managed)"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ec2-instance" {
  ami                                  = "ami-09d3b3274b6c5d4aa"
  instance_type                        = "t2.small"
  vpc_security_group_ids               = [aws_security_group.ec2-machine-sec-group.id]
  subnet_id                            = data.aws_subnet.selected.id
  key_name                             = aws_key_pair.generated_key.key_name
  iam_instance_profile                 = aws_iam_instance_profile.ec2-profile.name
  instance_initiated_shutdown_behavior = "terminate"
  associate_public_ip_address          = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }

}

resource "local_file" "ssh-file" {
  content  = tls_private_key.my-key.private_key_pem
  filename = "${path.module}/key.pem"
}