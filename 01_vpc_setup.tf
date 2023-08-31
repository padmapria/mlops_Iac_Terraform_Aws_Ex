# Step 1: Create a VPC
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MyVPC"
    }
}

# Step 2: Create a Public Subnet
resource "aws_subnet" "PublicSubnet" {
    vpc_id            = aws_vpc.myvpc.id
    availability_zone = "us-east-1a"
    cidr_block        = "10.0.1.0/24"
}

# Step 3: Create a Private Subnet
resource "aws_subnet" "PrivSubnet" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = true
}

# Step 4: Create an Internet Gateway (IGW)
resource "aws_internet_gateway" "myIgw" {
    vpc_id = aws_vpc.myvpc.id
}

# Step 5: Create Route Table for Public Subnet
resource "aws_route_table" "PublicRT" {
    vpc_id = aws_vpc.myvpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIgw.id
    }
}

# Step 6: Associate Route Table with Public Subnet
resource "aws_route_table_association" "PublicRTAssociation" {
    subnet_id       = aws_subnet.PublicSubnet.id
    route_table_id = aws_route_table.PublicRT.id
}


#Additional explanation for each step:

# Step 1: A Virtual Private Cloud (VPC) is created with a specified CIDR block.
# It's tagged with the name "MyVPC".

# Step 2: A public subnet is created within the VPC in availability zone "us-east-1a".
# The subnet has the CIDR block "10.0.1.0/24".

# Step 3: A private subnet is created within the same VPC.
# The subnet has the CIDR block "10.0.2.0/24".
# The attribute "map_public_ip_on_launch" is set to true, allowing instances to have public IP addresses.

# Step 4: An Internet Gateway (IGW) is created and associated with the VPC.
# This allows instances in the VPC to access the internet.

# Step 5: A route table is created for the VPC.
# A default route ("0.0.0.0/0") is added, pointing to the Internet Gateway created in step 4.
# This makes the subnet created in step 2 a public subnet.

# Step 6: The route table created in step 5 is associated with the public subnet created in step 2.
# This ensures that instances in the public subnet use the specified route table for their networking configuration.