#!/bin/bash

sudo dnf update -y
sudo dnf -y install httpd
sudo dnf -y install php8.1 php-mysqli

wget https://ja.wordpress.org/wordpress-6.2.2-ja.tar.gz
tar xzf wordpress-latest-ja.tar.gz
sudo cp -r wordpress/* /var/www/html/
sudo chown -R apache:apache /var/www/html

sudo systemctl start httpd.service