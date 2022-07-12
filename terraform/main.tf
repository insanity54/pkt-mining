terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.11.3"
    }
  }
}

provider "vultr" {
  # In your .bashrc or shell env you need to set
  # export VULTR_API_KEY="Your Vultr API Key"
  retry_limit = 5
}


# Create virtual private server(s)
resource "vultr_instance" "miner" {
  count                  = var.instance_count
  tags                   = ["pkt"]
  activation_email       = false
  backups                = "disabled"
  label                  = "pkt miner ${count.index}"
  enable_ipv6            = false
  os_id                  = var.ubuntu_jammy
  region                 = var.vultr_dallas
  plan                   = var.one_cpu_one_gb_ram
}



# Create an inventory file which Ansible can use
# to provision the VPS
resource "local_file" "AnsibleInventory" {
  content = templatefile("${path.root}/templates/inventory.tmpl", {
    miners = vultr_instance.miner
  })
  filename = "inventory"
}
