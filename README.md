# Superfast LEMP-WP Stack<!-- omit in toc -->

## Table of Contents<!-- omit in toc -->

- [Introduction](#introduction)
- [Components](#components)
- [Prerequisites](#prerequisites)
- [1. Initial Server Setup](#1-initial-server-setup)
    - [1.1 Login to the Server](#11-login-to-the-server)
    - [1.2 Create User with Superuser Privileges](#12-create-user-with-superuser-privileges)
    - [1.3 Create SSH Credentials](#13-create-ssh-credentials)
    - [1.4 Secure root login](#14-secure-root-login)
    - [1.5 Update Ubuntu](#15-update-ubuntu)
- [2. Install Nginx](#2-install-nginx)
- [3. Install PHP](#3-install-php)
- [4. Setup `UFW` Firewall](#4-setup-ufw-firewall)
    - [4.1 Enable `UFW` Firewall](#41-enable-ufw-firewall)
    - [4.2 Install and enable `fail2ban`](#42-install-and-enable-fail2ban)
- [Configure Nginx Server Blocks](#configure-nginx-server-blocks)
    - [Useful Commands](#useful-commands)

## Introduction

## Components

## Prerequisites

## 1. Initial Server Setup

### 1.1 Login to the Server

``` bash
ssh root@142.93.200.70
```

### 1.2 Create User with Superuser Privileges

``` bash
adduser tharindu
usermod -aG sudo tharindu
sudo su - tharindu
```

### 1.3 Create SSH Credentials

``` bash
mkdir ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys

# Paste the contents from pbcopy < ~/.ssh/id_rsa.pub

chmod 600 ~/.ssh/authorized_keys
```

### 1.4 Secure root login

``` bash
sudo nano /etc/ssh/sshd_config

# Set 'PermitRootLogin yes' to `PermitRootLogin no` and `PasswordAuthentication yes` to `PasswordAuthentication no`.

sudo service ssh restart
```

### 1.5 Update Ubuntu

``` bash
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo reboot
```

## 2. Install Nginx

``` bash
sudo add-apt-repository ppa:nginx/development -y
sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl status nginx
```

``` bash
sudo nano /etc/nginx/nginx.conf
```

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

## 3. Install PHP

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

## 4. Setup `UFW` Firewall

### 4.1 Enable `UFW` Firewall

``` bash
sudo apt-get install ufw
sudo ufw app list
sudo ufw allow OpenSSH 
sudo ufw allow 'Nginx Full'
sudo ufw show added
sudo ufw enable
sudo ufw status verbose
```

### 4.2 Install and enable `fail2ban`

``` bash
sudo apt-get install fail2ban -y
sudo service fail2ban start
```

## Configure Nginx Server Blocks

``` bash
/var/www/
├── hostingexplorer.com
│   └── public_html
│   └── cache
│   └── logs
├── domain2.com
│   └── public_html
│   └── cache
│   └── logs
├── html
```

``` bash
sudo mkdir -p /var/www/hostingexplorer.com/public_html
sudo mkdir /var/www/hostingexplorer.com/cache
sudo mkdir /var/www/hostingexplorer.com/logs
```

``` bash
sudo chown -R www-data: /var/www/hostingexplorer.com
```

``` bash
sudo rm -f /etc/nginx/sites-enabled/default
```

``` bash
sudo touch /etc/nginx/sites-available/hostingexplorer.com
```

### Useful Commands

Copy remote file content ```ssh tharindu@142.93.200.70  "cat /etc/nginx/nginx.conf"|pbcopy```
