# Superfast LEMP-WP Stack<!-- omit in toc -->

## Introduction

## Components

## Prerequisites

## Initial Server Setup

### → Login to the Server

``` bash
ssh root@142.93.200.70
```

### → Create User with Superuser Privileges

``` bash
adduser tharindu
usermod -aG sudo tharindu
sudo su - tharindu
```

### → Create SSH Credentials

``` bash
mkdir ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys

# Paste the contents from pbcopy < ~/.ssh/id_rsa.pub

chmod 600 ~/.ssh/authorized_keys
```

### → Secure root login

``` bash
sudo nano /etc/ssh/sshd_config

# Set 'PermitRootLogin yes' to `PermitRootLogin no` and `PasswordAuthentication yes` to `PasswordAuthentication no`.

sudo service ssh restart
```

### → Update Ubuntu

``` bash
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo reboot
```

## Install Nginx and Configure

### → Install Nginx

``` bash
sudo add-apt-repository ppa:nginx/development -y
sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl status nginx
```

### → Configure Nginx for Optimum Performance

``` bash
sudo nano /etc/nginx/nginx.conf
```

``` nginx
# Change number 2 to match with the number of cores you have
worker_processes 2;

# multiply number of cores from the output of this command `ulimit -n`
worker_connections 2048;
use epoll;

keepalive_timeout 10;

# uncomment this line and set to off
server_tokens off;
client_max_body_size 64m;

# Add the following lines to the config file
client_body_buffer_size 128k;
client_header_buffer_size 10k;
client_max_body_size 10m;
large_client_header_buffers 4 256k;
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

``` bash
sudo nano /etc/php/7.2/fpm/php.ini

# Add these following items to match 'client_max_body_size 64m'

# upload_max_filesize = 64M
# post_max_size = 64M

sudo php-fpm7.2 -t
sudo service php7.2-fpm restart
```

## Setup `UFW` Firewall

### → Install `UFW` Firewall

``` bash
sudo apt-get install ufw
sudo ufw app list
sudo ufw allow OpenSSH 
sudo ufw allow 'Nginx Full'
sudo ufw show added
sudo ufw enable
sudo ufw status verbose
```

### → Install and enable `fail2ban`

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
sudo chown -R tharindu: /var/www/hostingexplorer.com
```

``` bash
sudo rm -f /etc/nginx/sites-enabled/default
```

``` bash
cd /etc/nginx/sites-available
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/hostingexplorer.com
sudo ln -s /etc/nginx/sites-available/hostingexplorer.com /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## Install MariaDB

### → Install MariaDB

``` bash
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://suro.ubaya.ac.id/mariadb/repo/10.3/ubuntu bionic main'
sudo apt update
sudo apt install mariadb-server
sudo systemctl status mariadb
sudo mysql_secure_installation
```

### → Create Database

``` sql
mysql -u root -p
CREATE DATABASE h0571n63xpl0r3r CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
CREATE USER 'h0571n6u'@'localhost' IDENTIFIED BY '#cu9yVlFSwZu&KHg1o*6';
GRANT ALL PRIVILEGES ON h0571n63xpl0r3r.* TO 'h0571n6u'@'localhost';
FLUSH PRIVILEGES;
exit;
```

## Install WordPress

``` bash
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar xf latest.tar.gz
sudo mv /tmp/wordpress/* /var/www/hostingexplorer.com/public_html
```

## Install Redis

``` bash
sudo apt-get install redis-server
```

``` bash
sudo nano /etc/nginx/sites-available/hostingexplorer.com

# Add 'fastcgi_cache_path /var/www/hostingexplorer.com/cache levels=1:2 keys_zone=hostingexplorer.com:100m inactive=60m;' before the server block
```

## HTTPS and HTTPS/2

``` bash
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-nginx
sudo certbot --nginx certonly
```

``` nginx
# Add these lines into /etc/nginx/sites-available/hostingexplorer.com

ssl_certificate /etc/letsencrypt/live/hostingexplorer.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/hostingexplorer.com/privkey.pem;

```

## Useful Commands

Copy remote file content ```ssh tharindu@206.189.203.233  "cat /etc/nginx/sites-available/hostingexplorer.com"|pbcopy```
