#!/bin/bash

# Java, Maven, Jenkins, Git

# Allocate disk space
if ! sudo mount -o remount,size=3G /tmp; then
        echo 'Failed to allocate disk space'
        exit 1
fi

# Jenkins keys
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Java
if ! sudo yum install fontconfig java-17-amazon-corretto -y; then
        echo 'Failed to install java'
        exit 1
fi

# Install Jenkins
if ! sudo yum install jenkins -y; then
        echo 'Failed to install jenkins'
        exit 1
fi

# Start jenkins
sudo service jenkins start

# Echo jenkins password
if service jenkins status | grep -q 'inactive'; then
    echo 'jenkins failed to start'
    exit 1
fi

# Install Maven
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
if ! tar -xvzf apache-maven-3.9.9-bin.tar.gz; then
        echo 'Cannot unzip maven'
        exit 1
fi
mv apache-maven-3.9.9 maven

# Add Path
echo 'M2_HOME=/opt/maven
M2=/opt/maven/bin
JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64

PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2
export PATH' > ~/.bashrc

source ~/.bashrc

# Install Git
if ! sudo yum install git -y; then
        echo 'Failed to install git'
        exit 1
fi

# Get key
echo "initialAdminPassword=$(cat /var/lib/jenkins/secrets/initialAdminPassword)"

