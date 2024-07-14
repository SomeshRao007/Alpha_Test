resource "aws_instance" "ec2-node-server" {
  ami                    = "ami-05e00961530ae1b55" #from https://bitnami.com/stack/nodejs/cloud/aws/amis
  instance_type          = "t3a.small"
  vpc_security_group_ids = [aws_security_group.HelloSG.id]
  subnet_id              = aws_subnet.subnet1.id
  key_name               = "NestJs_server"

  root_block_device {
    volume_size = 35    # Size in GB
    volume_type = "gp3" # General Purpose SSD
  }


  tags = {
    Name = "terraform-aws-Ubuntu_debian_based"
  }

  provisioner "remote-exec" { # keep this block inside resource block and save hours of time on the internet
    inline = [

      "sudo apt-get update",
      "sudo curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -",

      "sudo apt install -y nodejs",
      "sudo npm install -g yarn",
      "sudo apt-get install git -y",
      "sudo apt-get install -y awscli",

      "git clone --single-branch --branch main https://github.com/SomeshRao007/Terra_Strapi.git",
      "cd Terra_Strapi/",
      "git pull origin main",

      "sudo apt-get update -y",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository -y \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update -y",
      "sudo apt-get install -y docker-ce",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ubuntu",

      "sudo curl -L \"https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",

      #"aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 469563970583.dkr.ecr.ap-south-1.amazonaws.com",
      "sudo cd /home/ubuntu/Alpha_Test",
      "sudo docker pull someshrao007/strapi:latest",
      "sudo docker-compose up -d"
      # "docker pull 469563970583.dkr.ecr.ap-south-1.amazonaws.com/somesh007:latest",

      # "docker run -d -p 1337:1337 alpha_test_strapi:latest",
      # "cd /home/ubuntu/Alpha_Test",
      # "docker-compose up -d"



    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      #private_key = file("/home/somesh/Desktop/AWS_IAC/nestjsserver.pem") # Replace with your private key path
      private_key = file(var.ssh_private_key)
      host        = self.public_ip
      #private_key = aws_key_pair.deployer.id

    }
  }


}


