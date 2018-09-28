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

```bash
# Login to the server
$ ssh root@178.128.156.148

# Add new user from here
$ adduser tharindu

# Add newly created user into group of sudo
$ usermod -aG sudo tharindu

# Run the app
$ npm start
```

## Install Nxinx

```console
$ whoami
$ sudo apt-get install nginx -y
$ sudo apt-get update && apt-get upgrade
```

## Install PHP and other modules

```shell
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install php7.2-fpm php7.2-common php7.2-mysql php7.2-xml php7.2-xmlrpc php7.2-curl php7.2-gd php7.2-imagick php7.2-cli php7.2-dev php7.2-imap php7.2-mbstring php7.2-opcache php7.2-redis php7.2-soap php7.2-zip -y
php-fpm7.2 -v
```

```conf
user ashley;
worker_processes 1;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 1024;
	multi_accept on;
}

http {

	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 15;
	types_hash_max_size 2048;
	server_tokens off;
	client_max_body_size 64m;

	# server_names_hash_bucket_size 64;
	# server_name_in_redirect off;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# SSL Settings
	##

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;
	
	##
	# Logging Settings
	##

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	##
	# Gzip Settings
	##

	gzip on;
	gzip_disable "msie6";

	# gzip_vary on;
	gzip_proxied any;
	gzip_comp_level 2;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

	##
	# Virtual Host Configs
	##

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;

	server {
		listen 80 default_server;
		listen [::]:80 default_server;
		server_name _;
		return 444;
	}
}
```
