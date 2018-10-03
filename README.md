# Superfast LEMP-WP Stack<!-- omit in toc -->

## Table of Contents<!-- omit in toc -->

- [Introduction](#introduction)
- [Components](#components)
- [Prerequisites](#prerequisites)
- [Initial Server Setup](#initial-server-setup)
    - [Login to the Server](#login-to-the-server)
    - [Create User with Superuser Privileges](#create-user-with-superuser-privileges)
    - [Create SSH Credentials](#create-ssh-credentials)
    - [Secure root login](#secure-root-login)
    - [Update Ubuntu](#update-ubuntu)
- [Install Nginx](#install-nginx)
    - [Enable `UFW` Firewall](#enable-ufw-firewall)
    - [Install and enable `fail2ban`](#install-and-enable-fail2ban)
- [Install PHP](#install-php)
    - [Useful Commands](#useful-commands)

## Introduction

## Components

## Prerequisites

## Initial Server Setup

### Login to the Server

``` bash
ssh root@142.93.200.70
```

### Create User with Superuser Privileges

``` bash
adduser tharindu
usermod -aG sudo tharindu
sudo su - tharindu
```

### Create SSH Credentials

``` bash
mkdir ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys

# Paste the contents from pbcopy < ~/.ssh/id_rsa.pub

chmod 600 ~/.ssh/authorized_keys
```

### Secure root login

``` bash
sudo nano /etc/ssh/sshd_config

# Set 'PermitRootLogin yes' to `PermitRootLogin no` and `PasswordAuthentication yes` to `PasswordAuthentication no`.
```

``` bash
sudo service ssh restart
```

### Update Ubuntu

``` bash
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo reboot
```

## Install Nginx

``` bash
sudo add-apt-repository ppa:nginx/development -y
sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl status nginx
```

### Enable `UFW` Firewall

``` bash
sudo apt-get install ufw
sudo ufw app list
sudo ufw allow OpenSSH 
sudo ufw allow 'Nginx Full'
sudo ufw show added
sudo ufw enable
sudo ufw status verbose
```

### Install and enable `fail2ban`

``` bash
sudo apt-get install fail2ban -y
sudo service fail2ban start
```

## Install PHP

``` bash
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install php7.2-fpm php7.2-common php7.2-mysql php7.2-xml php7.2-xmlrpc php7.2-curl php7.2-gd php7.2-imagick php7.2-cli php7.2-dev php7.2-imap php7.2-mbstring php7.2-opcache php7.2-redis php7.2-soap php7.2-zip -y
systemctl status php7.2-fpm
sudo systemctl restart nginx
```

``` bash
sudo sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/fpm/php.ini
```

Open nginx conf file using this command and edit the followings.

``` bash
sudo nano /etc/nginx/nginx.conf
```

Change above files in config file

``` nginx

# I have 2 cores
worker_processes 2;

# multiply number of cores from the output of this command `ulimit -n`
worker_connections 2048;
use epoll;

keepalive_timeout 10;

# Add the following lines to the config file
client_body_buffer_size 128k;
client_header_buffer_size 10k;
client_max_body_size 10m;
large_client_header_buffers 4 256k;
```

Install PHP and other modules



``` bash
sudo mkdir -p /var/www/hostingexplorer.com/public_html
sudo mkdir /var/www/hostingexplorer.com/cache
sudo mkdir /var/www/hostingexplorer.com/logs
```

Change permissions

``` bash
sudo chown -R www-data: /var/www/hostingexplorer.com
```

Delete the default site configuration provided with the package as an example:

``` bash
sudo rm -f /etc/nginx/sites-enabled/default
```

Create a file inside sites-available directory

``` bash
sudo touch /etc/nginx/sites-available/hostingexplorer.com
```

### Useful Commands

Copy remote file content ```ssh tharindu@142.93.200.70  "cat /etc/nginx/nginx.conf"|pbcopy```
