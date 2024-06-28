# resource "aws_instance" "ec2-node-server" {
#   ami                    = "ami-05e00961530ae1b55"
#   instance_type          = "t3a.small"
#   vpc_security_group_ids = [aws_security_group.HelloSG.id]
#   subnet_id              = aws_subnet.subnet1.id
#   key_name               = "NestJs_server"
#   tags = {
#     Name = "terraform-aws-Ubuntu_debian_based"
#   }

#   user_data = <<-EOF
#               #!/bin/bash
#               sudo apt-get update
#               curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
#               sudo apt install -y nodejs
#               sudo npm install -g yarn
#               sudo apt-get install git -y
#               sudo apt-get install -y awscli

#               sudo apt-get update -y
#               sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
#               curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#               sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#               sudo apt-get update -y
#               sudo apt-get install -y docker-ce
#               sudo systemctl start docker
#               sudo systemctl enable docker
#               sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#               sudo chmod +x /usr/local/bin/docker-compose

#               EOF

#   provisioner "remote-exec" {
#     inline = [
#       "git clone --single-branch --branch main https://github.com/SomeshRao007/Alpha_Test.git",
#       "cd Alpha_Test/",
#       "git pull origin somesh",
#       "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 469563970583.dkr.ecr.ap-south-1.amazonaws.com",
#       "sudo docker pull 469563970583.dkr.ecr.ap-south-1.amazonaws.com/somesh007:latest",
#       "sudo docker run -d -p 1337:1337 alpha_test_strapi:latest",
#       "cd /home/ubuntu/Alpha_Test",
#       "sudo docker-compose up -d"
#     ]
#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = file("/home/somesh/Desktop/AWS_IAC/nestjsserver.pem")
#       host        = self.public_ip
#     }
#   }
# }