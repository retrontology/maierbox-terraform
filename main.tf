terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = ">= 0.7.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

# Base volume
resource "libvirt_volume" "base" {
  name   = "ubuntu-base.qcow2"
  pool   = "default"
  format = "qcow2"

  create = {
    content = {
        url = "https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
    }
  }
}

# Control Pane 1 disk
resource "libvirt_volume" "cp1_disk" {
  name           = "cp1.qcow2"
  pool           = "default"
  base_volume_id = libvirt_volume.base.id
  size           = 20 * pow(1024, 3)
}

# Control Pane 1 VM
resource "libvirt_domain" "cp1" {
  name   = "cp1"
  memory = 2048
  vcpu   = 2
  autostart = true

  disk {
    volume_id = libvirt_volume.cp1_disk.id
  }

  cloudinit = libvirt_cloudinit_disk.init_base.id

  /*network_interface {
    network_name = "default"
  }*/

}