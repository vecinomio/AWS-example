resource "aws_instance" "web" {
  ami             = "${var.ami}" #Ubuntu 18.04 LTS
  instance_type   = "t2.micro"
  key_name        = "${var.key_name}"
  monitoring      = "false"
  security_groups = ["${aws_security_group.new_Alex_task1_SSH_HTTP_HTTPS_8080.name}"]

  #vpc_security_group_ids = ["sg-08e2a8d9e3b72f8e5"] # Alex-task1-SSH-HTTP-HTTPS-8080
  root_block_device = {
    volume_size = "10"
    volume_type = "gp2"
  }

  tags {
    Name = "ubic"
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "file" {
    source      = "./task1"
    destination = "/tmp/task1"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "bash /tmp/script.sh",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("imaki_Frankfurt.pem")}"
  }
}
