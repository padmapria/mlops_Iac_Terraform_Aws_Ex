resource "aws_instance" "terraform_ex" {
  ami           = "ami-051f7e7f6c2f40dc1"
  instance_type = "t2.micro"
  key_name = "srilatha_28Aug2023"
  count=1
  
  # Associate the security group with the instance
  vpc_security_group_ids  = [aws_security_group.TF_SG.id]
  
  # If need to attach via vpc
  #subnet_id = aws_subnet.PublicSubnet.id
 
  tags = {
    Name = "priya_ec2"
  }
  
  depends_on = [aws_security_group.TF_SG]  # Wait for the security group to be created
}

output "my-public-ip"{
       value= aws_instance.terraform_ex.*.public_ip
}

locals {
  instance_count = length(aws_instance.terraform_ex)
}

resource "aws_s3_bucket" "example" {
  bucket = "priya-mlops-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

