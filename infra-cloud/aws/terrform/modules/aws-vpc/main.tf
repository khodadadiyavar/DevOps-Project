resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_a_cidr_block
  availability_zone       = var.subnet_a_az
  map_public_ip_on_launch = var.subnet_a_public

  tags = {
    Name = var.subnet_a_name
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_b_cidr_block
  availability_zone       = var.subnet_b_az
  map_public_ip_on_launch = var.subnet_b_public

  tags = {
    Name = var.subnet_b_name
  }
}

resource "aws_subnet" "subnet_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_c_cidr_block
  availability_zone       = var.subnet_c_az
  map_public_ip_on_launch = var.subnet_c_public

  tags = {
    Name = var.subnet_c_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.internetgw_name
  }
}


resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = var.route_tb_name
  }
}

resource "aws_route_table_association" "subnet_assoc" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.main.id
}

resource "aws_eip" "devops-project-pool" {
  domain           = "vpc"
  public_ipv4_pool = var.byoip_pool_name
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.devops-project-pool.allocation_id
  subnet_id     = aws_subnet.subnet_b.id

  tags = {
    Name = var.nat_gw_name
  }
  depends_on = [aws_internet_gateway.main]
}

resource "aws_security_group" "default_security_group" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DefaultSecurityGroup"
  }
}


# Output the NAT Gateway or Instance Public IP for reference
output "nat_public_ip" {
  value = aws_nat_gateway.nat_gateway.public_ip
  # Uncomment the line below if using NAT Instance
  # value = aws_instance.nat_instance.public_ip
}
