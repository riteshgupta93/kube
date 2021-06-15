provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "sg_22" {
  name = "sg_22"
  vpc_id = "vpc-0213c8fe71851c24010"
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example-ritesh"
  image_id      = "ami-03d5c68bab01f3496"
  instance_type = "t2.micro"
  user_data_base64 = base64encode(templatefile("${path.module}/template/node-user_data.sh", {}))
  key_name = "ritesh-ec2"
  security_groups = [aws_security_group.sg_22.id] 

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                 = "terraform-asg-example"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier  = ["subnet-012ff91482df1610710"]

  lifecycle {
    create_before_destroy = true
  }
}
