#!/bin/bash

sudo yum update -y
sudo yum -y install httpd
sudo systemctl start httpd.service