# Create VPC
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "terraform_vpc"
  }
}

#Create subnet
##Private Subnet 
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-subnet"
  }
}
##Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

#Create internet gateway
resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "terraform-vpc-IGW"
    }
}

#Create public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "public-route-table"
  }
}

#Create public-route
resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform-igw.id
}

#Connect public subnet with route table
resource "aws_route_table_association" "public-subnet-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

#Create Elastic IP
resource "aws_eip" "nat-eip" {
  tags = {
    Name = "nat-eip"
    }
}
#Create nat-gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public-subnet.id
  tags = {
      Name = "nat-gateway"
      }
}
#Create private route table 
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "private-route-table"
  }
}
#Create private-route
resource "aws_route" "private-route" {
  route_table_id         = aws_route_table.private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gateway.id
}
#Connect private subnet with route table
resource "aws_route_table_association" "private-subnet-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-route-table.id
}

#Create Default Security Group
resource "aws_security_group" "default_sg" {
  vpc_id = aws_vpc.terraform-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "default_sg"
  }
}
# Security Group for Public EC2
resource "aws_security_group" "public-ec2-sg" {
  vpc_id = aws_vpc.terraform-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["171.252.153.13/32"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-ec2-sg"
  }
}

# Security Group for Private EC2 
resource "aws_security_group" "private-ec2-sg" {
  vpc_id = aws_vpc.terraform-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.public-ec2-sg.id]  # allow connection from Public EC2
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-ec2-sg"
  }
}

# Public EC2 instance
resource "aws_instance" "public-ec2" {
  ami           = "ami-005fc0f236362e99f"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.public-ec2-sg.id]
  associate_public_ip_address  = true
  key_name      = "group2-keypair"  

  tags = {
    Name = "public-ec2"
  }
}

# Private EC2 instance
resource "aws_instance" "private-ec2" {
  ami           = "ami-005fc0f236362e99f"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private-subnet.id
  vpc_security_group_ids = [aws_security_group.private-ec2-sg.id]
  key_name      = "group2-keypair"  

  tags = {
    Name = "private-ec2"
  }
}
