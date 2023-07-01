#!/bin/bash

sudo dnf update -y
sudo dnf -y install httpd
sudo dnf -y install php8.1 php-mysqli

sudo wget -P /tmp https://ja.wordpress.org/wordpress-latest-ja.tar.gz
sudo tar xzf /tmp/wordpress-latest-ja.tar.gz -C /tmp
sudo cp -r /tmp/wordpress/* /var/www/html
sudo chown -R apache:apache /var/www/html

sudo systemctl start httpd.service