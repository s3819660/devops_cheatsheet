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