resource "aws_key_pair" "ter-key" {
  key_name   = "ter-key"
  public_key = file("ter.pub")
}
resource "aws_instance" "ter-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = var.IT
  availability_zone      = var.ZONE
  subnet_id              = aws_subnet.ter-pub-sub.id
  key_name               = aws_key_pair.ter-key.key_name
  vpc_security_group_ids = [aws_security_group.ter-sg.id]
  tags = {
    Name = "ter-inst"
  }
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  connection {
    user        = var.USER
    private_key = file("ter")
    host        = self.public_ip
  }
}
resource "aws_ebs_volume" "ter-ext-vol" {
  availability_zone = var.ZONE
  size              = 3
  tags = {
    Name = "ter-ext-vol"
  }
}
resource "aws_volume_attachment" "attach-vol" {
  device_name = "/dev/xvdh"
  instance_id = aws_instance.ter-inst.id
  volume_id   = aws_ebs_volume.ter-ext-vol.id
}
output "IP" {
  value = aws_instance.ter-inst.public_ip
}