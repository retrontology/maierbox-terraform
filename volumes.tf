# Volume pool
resource "libvirt_pool" "k8s" {
  name = "k8s"
  type = "dir"
  target = {
    path = "/var/lib/libvirt/images/k8s"
  }
}

# Base volume
resource "libvirt_volume" "ubuntu-base" {
  name   = "ubuntu-24.04.qcow2"
  pool   = libvirt_pool.k8s.name

  target = {
    format = {
      type = "qcow2"
    }
  }

  create = {
    content = {
        url = "https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
    }
  }
}

# Node volumes
resource "libvirt_volume" "volumes" {
  for_each = { for node in var.nodes : node.name => node }
  name = "${each.value.name}-disk.qcow2"
  pool = libvirt_pool.k8s.name
  capacity = each.value.disk_capacity
  capacity_unit = each.value.disk_unit

  target = {
    format = {
      type = "qcow2"
    }
  }

  backing_store = {
    path   = libvirt_volume.ubuntu-base.path
    format = {
      type = "qcow2"
    }
  }

}
