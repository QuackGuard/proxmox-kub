variable "pm_api_url" {
  default = "https://PROXMOX-IP:8006/api2/json"
}

variable "pm_node" {
  default = "NODENAME"
}

variable "pm_user" {
  default = ""
}

variable "pm_password" {
  default = ""
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa.pub"
}