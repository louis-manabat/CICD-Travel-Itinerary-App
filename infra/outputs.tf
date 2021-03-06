output "endpoint" {
  description = "URL of the EC2 instance"
  value       = aws_lb.sic_app_lb.dns_name
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.sic_app_ec2[0].public_ip
}