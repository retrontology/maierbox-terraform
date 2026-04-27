resource "libvirt_cloudinit_disk" "nodes" {
  for_each = { for node in var.nodes : node.name => node }

  name = "${each.value.name}-cloudinit"

  meta_data = yamlencode({
    "instance-id"    = each.value.name
    "local-hostname" = each.value.name
  })

  user_data = templatefile("${path.module}/cloud-init/user-data.yaml.tftpl", {
    hostname = each.value.name
  })

  network_config = yamlencode({
    version = 2
    ethernets = {
      primary = {
        match = {
          name = "en*"
        }
        dhcp4 = true
        dhcp6 = false
      }
    }
  })
}
