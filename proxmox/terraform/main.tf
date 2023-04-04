resource "proxmox_vm_qemu" "control_plane" {
  count             = 1
  name              = "control-plane-${count.index}.k8s.cluster"
  target_node       = "${var.pm_node}"

  clone             = "ubuntu-2004-cloudinit-template"
  os_type           = "cloud-init"

  cores             = "4"
  cpu               = "host"
  memory            = 4096
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  sockets           = "1"
  disk {
    size            = "48G"
    type            = "scsi"
    storage         = "local"
    iothread        = 0
  }

  network {
    model           = "virtio"
    bridge          = "vmbr3"
    tag             = "50"
  }

  # cloud-init settings
  #adjust the ip and gateway addresses as needed
  ipconfig0 = "ip=10.200.100.1${count.index}/24,gw=10.200.100.254"
  sshkeys = file("${var.ssh_key_file}")
}

resource "proxmox_vm_qemu" "worker_nodes" {
  count             = 3
  name              = "worker-${count.index}.k8s.cluster"
  target_node       = "${var.pm_node}"

  clone             = "ubuntu-2004-cloudinit-template"
  os_type           = "cloud-init"

  cores             = "4"
  sockets           = "1"
  cpu               = "host"
  memory            = 4096
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  disk {
    size            = "48G"
    type            = "scsi"
    storage         = "local"
    iothread        = 0
  }

  network {
    model           = "virtio"
    bridge          = "vmbr3"
    tag             = "50"
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0 = "ip=10.200.100.10${count.index}/24,gw=10.200.100.254"
  sshkeys = file("${var.ssh_key_file}")
}
