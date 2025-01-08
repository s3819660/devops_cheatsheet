#!/bin/bash

echo "mongodb-server" > /etc/hostname
hostnamectl set-hostname mongodb-server

sudo tee /etc/yum.repos.d/mongodb-org-6.0.repo <<EOF
[mongodb-org-6.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/6.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc
EOF

sudo yum install -y mongodb-org
sudo sed -i "s/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g" /etc/mongod.conf
sudo systemctl start mongod
sudo systemctl enable mongod

mongod --version

sudo yum remove mongodb-mongosh -y
sudo yum install mongodb-mongosh-shared-openssl3 -y
sudo yum install mongodb-mongosh -y

cp /etc/mongod.conf.rpmsave /etc/mongod.conf