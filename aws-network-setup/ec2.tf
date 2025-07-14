resource "aws_instance" "web_ec2" {
  ami           = "ami-05f991c49d264708f"  #Amazon Ubuntu 22.04 eu-west-2 
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  
  root_block_device {
    volume_size = 20         # Size in GB
    volume_type = "gp3"      # General Purpose SSD (default: gp2)
    delete_on_termination = true
  }

  tags = {
    Name = "log-a-rythm-instance"
  }
}