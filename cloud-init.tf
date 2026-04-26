resource "libvirt_cloudinit_disk" "init_base" {
  name = "init_base.iso"
  pool = "default"
  user_data = data.template_file.user_data_base.rendered
}

data "template_file" "user_data_base" {
  template = file("${path.module}/cloud_init/base.cfg")
}

