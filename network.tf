resource "libvirt_network" "default" {
  name = "maierbox-k8s"
  mode = "bridge"
  bridge = "br0"
}