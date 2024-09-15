resource "aws_instance" "windows_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  tags = {
    Name = "Windows-EC2"
  } 
}

# AEBS volume to be attached to the instance
resource "aws_ebs_volume" "volume_for_windows" {
  availability_zone = aws_instance.windows_ec2.availability_zone
  size              = var.ebs_volume_size
  type              = "gp2"
}

resource "aws_volume_attachment" "vol_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.volume_for_windows.id
  instance_id = aws_instance.windows_ec2.id
}
