
# Setup Ansible
1. Install ansibe on Ubuntu 22.04 
   ```sh 
   sudo apt update
   sudo apt install software-properties-common
   sudo add-apt-repository --yes --update ppa:ansible/ansible
   sudo apt install ansible -y
   ```

2. Add Jenkins master and slave as hosts 
Add jenkins master and slave private IPs in the inventory file 
in this case, we are using /opt is our working directory for Ansible. 
   ```
    [jenkins-master]
    18.209.18.194
    [jenkins-master:vars]
    ansible_user=ec2-user
    ansible_ssh_private_key_file=/opt/dpo.pem
    [jenkins-slave]
    54.224.107.148
    [jenkins-slave:vars]
    ansible_user=ec2-user
    ansible_ssh_private_key_file=/opt/dpo.pem

   ```

   Inventry file in Yaml format
```
   all:
  hosts:
    host1:
      ansible_host: 192.168.1.101  # Replace with the IP or hostname of host1
      ansible_port: 22             # Replace with the SSH port if different
      ansible_user: ansible          # Replace with the SSH username for host1
      ansible_ssh_private_key_file=/opt/dpo.pem  # Replace with the SSH key for host1 (if not using SSH keys)

    host2:
      ansible_host: 192.168.1.102  # Replace with the IP or hostname of host2
      ansible_port: 22             # Replace with the SSH port if different
      ansible_user: ansible          # Replace with the SSH username for host2
      ansible_ssh_pass: password2  # Replace with the SSH key for host1 (if not using SSH keys)

    host3:
      ansible_host: 192.168.1.103  # Replace with the IP or hostname of host3
      ansible_port: 22             # Replace with the SSH port if different
      ansible_user: ansible          # Replace with the SSH username for host3
      ansible_ssh_pass: password3  # Replace with the SSH key for host1 (if not using SSH keys)
```

1. Test the connection  
   ```sh
   ansible -i hosts all -m ping 
   ```