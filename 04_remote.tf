resource "null_resource" "remote"{
count = local.instance_count

connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/padma/Desktop/aws_key/srilatha_28Aug2023.pem")  # Update with the path to your private key
	host  = element(aws_instance.terraform_ex.*.public_ip, count.index)
  }
provisioner "remote-exec" {
inline = [
  "sudo yum update -y",
  "sudo yum install git -y",
  "sudo yum install -y python3.11",       # Installing Python 3
  "sudo ln -s /usr/bin/python3.11 /usr/bin/python",  # Creating the symlink
  "curl -O https://bootstrap.pypa.io/get-pip.py",  # Download pip installer
  "sudo python get-pip.py",  # Install pip
  "rm get-pip.py",  # Clean up the pip installer
  "sudo yum install -y docker",
  "sudo service docker start",
  "sudo usermod -aG docker ec2-user",  # Adding the ec2-user to the docker group
  "sudo git clone https://github.com/padmapria/customerchurn_prediction_mlops_project.git",
  "cd customerchurn_prediction_mlops_project",  # Change directory
  "python -m pip install -r requirements.txt",   # Install packages from requirements.txt
  "mlflow server --backend-store-uri sqlite:///mlflow.db --default-artifact-root ./mlflow-artifacts --host 0.0.0.0",
  "prefect server start & prefect cloud login -k pnu_d",
  "python src/training_flow.py",
  "python src/runtest_deploy.py",
  "docker run -d myproject-image"
	]
	}
}