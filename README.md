## pkt-mining

A terraform & ansible thingy to set up PKT miner(s) on [Vultr](https://www.vultr.com/?ref=6822161).


### Local Requirements

* Terraform 
* Ansible
* VULTR_API_KEY defined in env

### Usage

Edit `./vars/main.yml` to set your PKT wallet address and desired number of cloud instances.

Install dependency roles via ansible galaxy

`ansible-galaxy install -r requirements.yml`

Spin up the instances and provision them as miners. Ansible invokes Terraform to spin-up servers, Terraform creates an inventory file, then ansible connects to the servers and provisions them as PKT announcement miners.

`ansible-playbook ./provision.yml`
