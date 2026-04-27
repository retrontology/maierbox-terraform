resource "libvirt_network" "k8s" {
  name = "maierbox-k8s"

  forward = {
    mode = "bridge"
  }

  bridge = {
    name = var.k8s_bridge_device
  }
}