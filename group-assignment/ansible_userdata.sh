#!/bin/bash

echo "jenkins-ansible-server" > /etc/hostname
hostnamectl set-hostname jenkins-ansible-server

# Install Git
sudo yum install -y git

# Install Docker
sudo yum install -y docker

# Install Jenkins
echo "tmpfs   /tmp    tmpfs   defaults,size=3G   0   0" >> /etc/fstab
mount -o remount /tmp
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl daemon-reload

usermod -aG docker jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

sudo systemctl enable docker
sudo systemctl start docker

# Install Ansible
useradd ansibleadmin
echo "ansibleadmin:rmit" | chpasswd
usermod -aG docker ansibleadmin
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo yum install -y ansible

# Enable password authentication
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Group Project
# Give Jenkins permissions to write to /etc/ansible/hosts
echo '[defaults]
host_key_checking = False' > /etc/ansible/ansible.cfg # Disable host key checking
if [ ! -f /etc/ansible/hosts ]; then
    sudo touch /etc/ansible/hosts
fi
chmod o+w /etc/ansible/hosts
echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers # Given Jenkins sudo permissions
# Generate ssh key for ansibleadmin
mkdir -p /home/ansibleadmin/.ssh
chmod 700 /home/ansibleadmin/.ssh
ssh-keygen -t rsa -b 4096 -f /home/ansibleadmin/.ssh/id_rsa -N "" -q
# chmod o=rx /home # allow jenkins to read ssh key
# chmod o=rx /home/ansibleadmin # allow jenkins to read ssh key
# chmod o=rx /home/ansibleadmin/.ssh 
chmod o=rx /home/ansibleadmin/.ssh/id_rsa.pub # allow jenkins to read ssh key
# sudo chmod 644 /home/ansibleadmin/.ssh/id_rsa.pub
usermod -aG ansibleadmin jenkins # Add jenkins to ansibleadmin group
chown root:ansibleadmin /home/ansibleadmin/.ssh/id_rsa.pub # Change ownership of ssh key to ansibleadmin

