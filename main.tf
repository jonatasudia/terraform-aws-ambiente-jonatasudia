data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value["instance_type"]

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    iterator = device
    content {
      device_name = device.value["device_name"]
      encrypted   = device.value["encrypted"]
      volume_size = device.value["volume_size"]
    }
  }

  tags = {
    Name = var.name
    Env  = var.environment
    data = data.aws_ami.ubuntu.platform_details
  }
}