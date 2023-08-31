# Create an AWS security group using Terraform
resource "aws_security_group" "TF_SG" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  
  # To attach security group to vpc
  #vpc_id      = aws_vpc.myvpc.id  # Reference to the VPC where this security group belongs

  # Ingress rules (incoming traffic)
  ingress {
    description      = "HTTPS"  # Description of the rule
    from_port        = 443      # Source port range
    to_port          = 443      # Destination port range
    protocol         = "tcp"    # Protocol type (TCP)
    cidr_blocks      = ["0.0.0.0/0"]  # Allow incoming traffic from any source IP
  }

  ingress {
    description      = "HTTP"   # Description of the rule
    from_port        = 80       # Source port range
    to_port          = 80       # Destination port range
    protocol         = "tcp"    # Protocol type (TCP)
    cidr_blocks      = ["0.0.0.0/0"]  # Allow incoming traffic from any source IP
  }

  ingress {
    description      = "SSH"    # Description of the rule
    from_port        = 22       # Source port range
    to_port          = 22       # Destination port range
    protocol         = "tcp"    # Protocol type (TCP)
    cidr_blocks      = ["0.0.0.0/0"]  # Allow incoming SSH traffic from any source IP
  }

  ingress {
    description      = "MLflow"  # Description of the rule
    from_port        = 5000     # Source port range
    to_port          = 5000     # Destination port range
    protocol         = "tcp"    # Protocol type (TCP)
    cidr_blocks      = ["0.0.0.0/0"]  # Allow incoming traffic on port 5000 from any source IP
  }

  # Egress rule (outgoing traffic)
  egress {
    from_port        = 0        # Source port range (all ports)
    to_port          = 0        # Destination port range (all ports)
    protocol         = "-1"     # Protocol type (-1 indicates all protocols)
    cidr_blocks      = ["0.0.0.0/0"]  # Allow outgoing traffic to any destination IP
  }

  # Tags for the security group
  tags = {
    Name = "TF_SG"  # Name tag for the security group
  }
  
  depends_on = [aws_vpc.myvpc]  # Wait for the vpc to be created
}
output "security_id_created"{
       value= aws_security_group.TF_SG.id
	}
