output "public_dns" {
  value       = aws_instance.docker_elastic_stack.public_dns
  description = "The public DNS name of the docker elastic stack"
}

output "public_ip" {
  value       = aws_instance.docker_elastic_stack.public_ip
  description = "The public IP of the docker elastic stack"
}