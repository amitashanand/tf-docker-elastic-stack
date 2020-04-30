terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "docker_elastic_stack" {
  ami                    = "ami-07c1207a9d40bc3bd"
  key_name               = "playground"
  instance_type          = "t2.large"
  vpc_security_group_ids = [aws_security_group.allow_elk.id]

  provisioner "file" {
    source      = "${path.module}/config/docker-compose.yml"
    destination = "/tmp/docker-compose.yml"

    connection {
      host        = aws_instance.docker_elastic_stack.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/config/playground.pem")
    }
  }

  provisioner "file" {
    source      = "${path.module}/config/sample-pipeline.conf"
    destination = "/tmp/sample-pipeline.conf"

    connection {
      host        = aws_instance.docker_elastic_stack.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/config/playground.pem")
    }
  }

  provisioner "file" {
    source      = "${path.module}/config/filebeat.yml"
    destination = "/tmp/filebeat.yml"

    connection {
      host        = aws_instance.docker_elastic_stack.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/config/playground.pem")
    }
  }

  provisioner "remote-exec" {
    script = "${path.module}/config/setup_elasticstack.sh"

    connection {
      host = aws_instance.docker_elastic_stack.public_ip
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/config/playground.pem")
    }
  }

  tags = {
    Name = "tf-docker-elastic-stack"
  }
}


