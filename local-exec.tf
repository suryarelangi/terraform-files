resource "aws_instance" "one" {
tags = {
Name = "practice"
}
ami = var.ami_id
instance_type = var.itype
count = 1

provisioner "local-exec" {
command = "echo 'Instance created with instance id : ${aws_instance.one[0].id}' >> instanceid.txt"
}
}
