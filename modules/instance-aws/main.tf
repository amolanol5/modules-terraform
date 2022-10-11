resource "aws_instance" "instace_one" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name

}
