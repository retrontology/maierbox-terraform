# Basic VM configuration
resource "libvirt_domain" "nodes" {
  for_each = { for node in var.nodes : node.name => node }
  name   = each.value.name
  memory = each.value.memory
  memory_unit   = each.value.memory_unit
  vcpu   = each.value.vcpu
  type   = "kvm"
  running = true
  autostart = true

  os = {
    type         = "hvm"
    type_arch    = "x86_64"
    type_machine = "q35"
    boot_devices = [
        { dev = "hd" }
      ]
  }

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
            network = libvirt_network.k8s.name
          }
        }
      }
    ]
  }
}
