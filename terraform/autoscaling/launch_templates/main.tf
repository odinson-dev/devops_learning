resource "aws_launch_template" "my_launch_template" {
  name_prefix   = "web-app-"
  image_id      = "ami-123456" # Replace with the latest AWS AMI ID for your region
  instance_type = "t2.micro"

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 20
      encrypted             = true
      delete_on_termination = true
    }
  }

  block_device_mappings {
    device_name = "/dev/sdb"
    ebs {
      volume_size           = 10
      encrypted             = true
      delete_on_termination = true
    }
  }

  iam_instance_profile {
    name = var.iam_instance_profile
  }


  user_data = base64encode(file("./setup.sh"))

  vpc_security_group_ids = [var.instance_sg_id]
}

output "launch_template_id" {
  value = aws_launch_template.my_launch_template.id
}

resource "aws_lb_target_group" "my_tg" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

output "my_tg" {
  value = aws_lb_target_group.my_tg.arn
}
