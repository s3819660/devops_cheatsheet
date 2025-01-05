#!/bin/bash
#   RMIT University Vietnam
#   Course: COSC2767 Systems Deployment and Operations
#   Semester: 2024C
#   Assessment: Assignment 1
#   Author: Your name (e.g. Nguyen Van Minh)
#   ID: Your student id (e.g. 1234567)
#   Created  date: dd/mm/yyyy (e.g. 31/07/2023)
#   Last modified: dd/mm/yyyy (e.g. 05/08/2023)
#   Acknowledgement: Acknowledge the resources that you use here. 

echo 's3819660' > /etc/hostname

ssh-keygen -t rsa -b 4096 -C "s3819660@rmit.edu.vn"


git config --global user.email "s3819660@rmit.edu.vn"
git config --global user.name "Phuc Nguyen"