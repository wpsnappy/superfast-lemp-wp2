# Superfast LEMP-WP Stack

## Introduction

WordPress itself has conqured 30% of it's marketplace. WordPress was made as a multi purpose CMS platform where most people would find most features not necessary.

## Components

| Component | Version |
| :---------- | :----------- |
| Linux | Ubuntu 18.04 x64 |
| Nginx | [1.14.1](#) |
| PerconaDB | [5.7](#) |
| PHP | [php7.2-fpm](#) |
| Fail2ban | [0.9.7](#) |
| Certbot | [0.28.0](#) |
| Postfix | [3.3.1](#) |

## Initial Server Setup

This section was taken from [Digitalocean](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04/) guide and it just get the job done.

Log into your server
```sh
ssh root@your_server_ip
```

Add new user from here
```sh
adduser tharindu
```

Add newly created user into group of sudo
```sh
usermod -aG sudo tharindu
```

## Install Nxinx

```sh
sudo apt-get install nginx -y
sudo apt-get update && apt-get upgrade
```

## Install PHP and other modules

```bash
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install php7.2-fpm php7.2-common php7.2-mysql php7.2-xml php7.2-xmlrpc php7.2-curl php7.2-gd php7.2-imagick php7.2-cli php7.2-dev php7.2-imap php7.2-mbstring php7.2-opcache php7.2-redis php7.2-soap php7.2-zip -y
php-fpm7.2 -v
```
