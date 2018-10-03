# Superfast LEMP-WP Stack<!-- omit in toc -->

## Table of Contents<!-- omit in toc -->

- [Introduction](#introduction)
- [Components](#components)
- [Prerequisites](#prerequisites)
- [Initial Server Setup](#initial-server-setup)
    - [Login to the Server](#login-to-the-server)
    - [Create User with Superuser Privileges](#create-user-with-superuser-privileges)
    - [Update Ubuntu](#update-ubuntu)
- [Install Nginx](#install-nginx)
- [Install PHP](#install-php)
- [Initial Server Setup](#initial-server-setup)
    - [Install Nginx](#install-nginx)
    - [Useful Commands](#useful-commands)

## Introduction

## Components

| Component | Version          |
| :-------- | :--------------- |
| Linux     | Ubuntu 18.04 x64 |
| Nginx     | [1.14.1](#)      |
| PerconaDB | [5.7](#)         |
| PHP       | [php7.2-fpm](#)  |
| Redis     | [Na](#)          |
| Fail2ban  | [0.9.7](#)       |
| Certbot   | [0.28.0](#)      |
| Postfix   | [3.3.1](#)       |

## Prerequisites

Make sure that you have met the following prerequisites before continuing with this tutorial:

- You have a domain name pointing to your public server IP. In this tutorial we will use ```stackpartner.com```.
- You are logged in as a user with sudo privileges.

## Initial Server Setup

### Login to the Server

Login to the server using your ip addess. Replace ```root``` with your username and ```178.128.156.148``` with your ip address.

``` bash
ssh root@142.93.200.70
```

### Create User with Superuser Privileges

The default root user is the administrative user in a Linux environment that has superuser privileges and you are discouraged from using it on a regular basis. For that reason, it is highly recommended that you set up an alternative account under your own name and assign it superuser privileges.

In this example we are going to use the ```adduser``` command to add a new user called **tharindu**. The ```sudo``` command at the beginning means  “superuser do!” and tells Linux to run the ensuing command with elevated superuser privileges, otherwise you may get an access denied error.

Add a new non-root sudo user. Replace ```tharindu``` with your preferred username.

``` bash
adduser tharindu
```

Once the new user is created, give it superuser privileges using the ```usermod``` command. The ```-aG``` parameter means append to Group, and the name of the superuser group is ```sudo```.

``` bash
usermod -aG sudo tharindu
```

We can now switch to our new account john using the su command (substitute user).

``` bash
sudo su - tharindu
```

### Update Ubuntu

## Install Nginx

## Install PHP

``` bash
# Document root
/var/www/hostingexplorer.com/public_html

# Cache
/var/www/hostingexplorer.com/cache

# Logs
/var/www/hostingexplorer.com/logs
```

## Initial Server Setup

``` bash
mkdir ~/.ssh
```

``` bash
chmod 700 ~/.ssh
```

``` bash
nano ~/.ssh/authorized_keys
```

``` bash
# pbcopy < ~/.ssh/id_rsa.pub
# paste
```

``` bash
chmod 600 ~/.ssh/authorized_keys
```

Set ```PermitRootLogin yes``` to ```PermitRootLogin no``` and ```PasswordAuthentication yes``` to ```PasswordAuthentication no```.

``` bash
sudo nano /etc/ssh/sshd_config
```

``` diff
- PermitRootLogin yes
+ PermitRootLogin no

- PasswordAuthentication yes
+ PasswordAuthentication no

```

``` bash
sudo service ssh restart
```

Reboot the server

``` bas
sudo reboot
```

Update the server

``` bash
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo reboot
```

### Install Nginx

``` bash
sudo add-apt-repository ppa:nginx/development -y
sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl status nginx
```

Setup the UFW firewall

``` bash
sudo apt-get install ufw
sudo ufw app list
sudo ufw allow OpenSSH 
sudo ufw allow 'Nginx Full'
sudo ufw show added
sudo ufw enable
sudo ufw status verbose
```

Install fail2ban

``` bash
sudo apt-get install fail2ban -y
sudo service fail2ban start
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
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install php7.2-fpm php7.2-common php7.2-mysql php7.2-xml php7.2-xmlrpc php7.2-curl php7.2-gd php7.2-imagick php7.2-cli php7.2-dev php7.2-imap php7.2-mbstring php7.2-opcache php7.2-redis php7.2-soap php7.2-zip -y
systemctl status php7.2-fpm
sudo systemctl restart nginx
```

Tell PHP to only accept URIs for files that actually exist on the server. This mitigates a security vulnerability where the PHP interpreter can be tricked into allowing arbitrary code execution if the requested .php file is not present in the filesystem.

``` bash
sudo sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/fpm/php.ini
```

Create a root directory where the site’s content will live. Replace `hostingexplorer.com` with your site’s domain.

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
