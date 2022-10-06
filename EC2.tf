module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.instance_name

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [module.web_server_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  user_data = <<EOF
#! /bin/bash
sudo yum update -y
sudo yum install maven -y
sudo yum install git -y
sudo yum install mysql -y
sudo cd /home/ec2-user/
git clone https://github.com/Shivaraj600/terraformbackendcode.git
EOF

}
