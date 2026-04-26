variable "nodes" {
  type = list(object({
    name = string
    type = string
    memory = number
    memory_unit = string
    vcpu = number
    disk_capacity = number
    disk_unit = string
  }))
  description = "List of nodes to create"
  default = [
    {
      name = "control-plane-0"
      type = "control-plane"
      memory = 2048
      memory_unit = "MiB"
      vcpu = 2
      disk_capacity = 20
      disk_unit = "GiB"
    },
    {
      name = "worker-0"
      type = "worker"
      memory = 4096
      memory_unit = "MiB"
      vcpu = 4
      disk_capacity = 20
      disk_unit = "GiB"
    },
    {
      name = "worker-1"
      type = "worker"
      memory = 4096
      memory_unit = "MiB"
      vcpu = 4
      disk_capacity = 20
      disk_unit = "GiB"
    }
  ]
}
