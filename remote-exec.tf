resource "aws_key_pair" "one" {
key_name = "learningKP"
public_key = file("/root/.ssh/id_rsa.pub")
}





resource "aws_instance" "two" {
tags = {
Name = "practice"
}
ami = var.ami_id
instance_type = var.itype
count = 1

provisioner "remote-exec" {
connection {
type = "ssh"
user = "ec2-user"
private_key = file("/root/.ssh/id_rsa")
host = self.public_ip
}
inline = [
"echo 'Hello World' ",
]
}
}
