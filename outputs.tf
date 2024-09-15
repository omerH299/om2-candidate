output "instance_id" {
  value       = aws_instance.windows_ec2.id
}

output "public_ip" {
  value       = aws_instance.windows_ec2.public_ip
}

output "ebs_volume_id" {
  description = "The ID of the attached EBS volume"
  value       = aws_ebs_volume.volume.id
}

output "availability_zone" {
  description = "The availability zone where the EC2 instance is running"
  value       = aws_instance.windows_ec2.availability_zone
}
