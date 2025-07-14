resource "aws_instance" "web_ec2" {
  ami           = "ami-08f79bee58074adeb"  #Amazon Ubuntu 22.04 eu-west-2
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "log-a-rythm-instance"
  }
}