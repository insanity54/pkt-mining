### The bastion

resource "aws_instance" "bastion" { 
    ami = var.ami 
    availability_zone = var.az 
    instance_type = "t2.micro" 
    key_name = var.ssh-key 
    vpc_security_group_ids = [
        aws_default_security_group.sg-public.id
    ]
    subnet_id = aws_subnet.public.id
    tags = {  
        Name = "Bastion"  
        Projet = var.projet  
        Application = var.Application 
    } 
    volume_tags = {
        Name = "Bastion"  
        Projet = var.projet  
        Application = var.Application 
    }

    root_block_device {
        volume_size = 8  
    }
}

### The Elastic IP for the Bastion

resource "aws_eip" "eip-bastion" { vpc = true instance = aws_instance.bastion.id associate_with_private_ip = aws_instance.bastion.private_ip tags = {  Name = "bastion"  Projet = var.projet  Application = var.Application }}


### The private instances

resource "aws_instance" "i-private" { 
    ami = var.ami 
    availability_zone = var.az 
    instance_type = var.ec2_type 
    key_name = var.ssh-key 
    vpc_security_group_ids = [
        aws_security_group.sg-private.id
    ]
    subnet_id = aws_subnet.private.id 
    tags = {  
        Name = "i-private"  
        Projet = var.projet  
        Application = var.Application 
    } 
    volume_tags = {
      Name = "i-private"  
      Projet = var.projet  
      Application = var.Application 
    } 
        root_block_device {
        volume_size = 8  
    } 
    ebs_block_device {
        device_name = "/dev/sdb"
        volume_type = var.ebs_type
        volume_size = 8 
    } 
    count = var.ec2_nb
}


# outputs.tf

### The Ansible inventoryfile

resource "local_file" "AnsibleInventory" {
    content = templatefile("inventory.tmpl", {
        bastion-dns = aws_eip.eip-bastion.public_dns,  bastion-ip = aws_eip.eip-bastion.public_ip,  bastion-id = aws_instance.bastion.id,  private-dns = aws_instance.i-private.*.private_dns,  private-ip = aws_instance.i-private.*.private_ip,  private-id = aws_instance.i-private.*.id 
    }) filename = "inventory"
}
vultr_instance



# inventory.tmpl
[bastion]
${bastion-dns} ansible_host=${bastion-ip} # ${bastion-id}

[servers]
%{ for index, dns in private-dns ~}${dns} ansible_host=${private-ip[index]} # ${private-id[index]}%{ endfor ~}