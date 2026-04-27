# Basic VM configuration
resource "libvirt_domain" "nodes" {
  for_each = { for node in var.nodes : node.name => node }
  name   = each.value.name
  memory = each.value.memory
  memory_unit   = each.value.memory_unit
  vcpu   = each.value.vcpu
  type   = "kvm"

  devices = {
    disks = [
      {
        source = {
          file = {
            file = libvirt_volume.volumes[each.value.name].path
          }
        }
        target = {
          dev = "vda"
          bus = "virtio"
        }
      }
    ]
    interfaces = [
      {
        model = {
          type = "virtio"
        }
        source = {
          network = {
            network = libvirt_network.default.name
          }
        }
      }
    ]
  }
}
