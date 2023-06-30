#!/bin/bash

sudo dnf update -y
sudo dnf -y install httpd

sudo systemctl start httpd.service