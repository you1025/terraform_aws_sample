#!/bin/bash

sudo dnf update -y
sudo dnf -y install httpd

sudo wget -O /var/www/html/index.html https://raw.githubusercontent.com/you1025/terraform_aws_sample/main/html/hello.html
sudo systemctl start httpd.service