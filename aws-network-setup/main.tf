# 1. VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "log-a-rythm-vpc"
  }
}

# 2. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "log-a-rythm-igw"
  }

}

# 3. Subnets
# public subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone
  
  tags = {
    Name = "log-a-rythm-public-subnet"
  }
}

#private subnet_1 (lambda)
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = var.availability_zone
  
  tags = {
    Name = "log-a-rythm-private-subnet-1"
  }
}

resource "aws_subnet" "private_rds" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = var.availability_zone
  
  tags = {
    Name = "log-a-rythm-private-subnet-2"
  }
}

# 4. Route Tables
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "log-a-rythm-rt"
  }
}

# Route: Public RT -> IGW
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# 5. Security Group
resource "aws_security_group" "public_sg" {
  name   = "log-a-rythm-public-sg"
  vpc_id = aws_vpc.main.id
  description = "Allow SSH/HTTP from internet"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For SSH - lock down in prod
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # HTTP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "log-a-rythm-public-sg"
  }
}

resource "aws_security_group" "rds_private_sg" {
  name   = "log-a-rythm-rds-private-sg"
  vpc_id = aws_vpc.main.id

  description = "Allow access only from public EC2 SG"

  ingress {
    from_port       = 3306          # Example: MySQL for RDS
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "log-a-rythm-rds-private-sg"
  }
}

resource "aws_security_group" "lambda_private_sg" {
  name   = "log-a-rythm-lambda-private-sg"
  vpc_id = aws_vpc.main.id

  description = "Allow access only from public EC2 SG"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "log-a-rythm-lambda-private-sg"
  }
}


resource "aws_security_group" "ec2_sg" {
  name        = "log-a-rythm-lambda-ec2-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Or your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "log-a-rythm-lambda-ec2-sg"
  }
}
