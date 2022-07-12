## pkt-mining

A terraform & ansible thingy to set up PKT miner(s) on [Vultr](https://www.vultr.com/?ref=6822161).


### Local Requirements

* Terraform 
* Ansible
* VULTR_API_KEY defined in env

### Usage

Edit `./vars/main.yml` to set your PKT wallet address and desired number of cloud instances.

Install the insanity54.pkt role via ansible galaxy

`ansible-galaxy install -r requirements.yml`

Run the following command to spin up the instances and provision them as miners.

`ansible-playbook ./provision.yml`
