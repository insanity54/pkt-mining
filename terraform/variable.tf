variable "vultr_dallas" {
  description = "Vultr Dallas Region"
  default = "dfw"
}

variable "ubuntu_jammy" {
  description = "Ubuntu 22.04 LTS x64"
  default = 1743
}

variable "one_cpu_one_gb_ram" {
  description = "1024 MB RAM,25 GB SSD,1.00 TB BW"
  default = "vc2-1c-1gb"
}


variable "instance_count" {
  description = "The number of miner instances to spin-up"
  default = 1
}

variable "vultr_ssh_keys" {
  type        = list(string)
  description = "Vultr key ID of the SSH keys to add to the server. ID is retrieved from https://my.vultr.com/settings/#settingssshkeys"
}