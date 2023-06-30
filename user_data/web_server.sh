#!/bin/bash

sudo dnf update -y
sudo dnf -y install httpd

# for mysql client
sudo dnf -y localinstall https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
sudo dnf -y install mysql-community-client

sudo systemctl start httpd.service