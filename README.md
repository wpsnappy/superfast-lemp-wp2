# Superfast LEMP-WP Stack<!-- omit in toc -->

## Table of Contents<!-- omit in toc -->

- [Introduction](#introduction)
- [Components](#components)
- [Initial Server Setup](#initial-server-setup)
  - [Login to the Server](#login-to-the-server)
  - [Create User with Superuser Privileges](#create-user-with-superuser-privileges)
  - [Update Ubuntu](#update-ubuntu)
  - [Set up Firewall](#set-up-firewall)
- [Install Nginx](#install-nginx)

## Introduction

The term LEMP is an acronym of the names of its four open-source components:

- L - Linux operating system
- E - Nginx [engine x] a HTTP and reverse proxy server
- M - MySQL or MariaDB relational database management system
- P - PHP programming language.

This series of tutorials will show you how to install Nginx, create Nginx server blocks, generate a free Let’s Encrypt SSL certificate, install and secure MySQL and install PHP 7.2.

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

## Initial Server Setup

### Login to the Server

Login to the server using your ip addess. Replace ```root``` with your username and ```178.128.156.148``` with your ip address.

``` bash
ssh root@178.128.156.148
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

Enter the password you created previously.

``` bash
Password:
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

john@178.128.156.148:~$
```

### Update Ubuntu

``` bash
sudo apt update && sudo apt upgrade
sudo apt autoremove
```

Once updated, you may need to run ```reboot``` to reboot the server:

``` bash
sudo reboot
```

### Set up Firewall

By default ```ufw``` is disabled. You can check it by running this command.

``` bash
sudo ufw status verbose
```

Enable Firewall.

``` bash
sudo ufw enable
```

Firewall is now enabled.

``` bash
sudo ufw status
```

## Install Nginx

Nginx packages are available in the default Ubuntu repositories. The installation is pretty straightforward. We’ll start by updating the local package index and then install Nginx:

``` bash
$ sudo apt update
$ sudo apt install nginx
```

Once the installation is completed, Nginx service will start automatically. You can check the status of the service with the following command:

``` bash
sudo systemctl status nginx
```

The output will look something like this:

``` bash
# Output
● nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2018-04-29 06:43:26 UTC; 8s ago
     Docs: man:nginx(8)
  Process: 3091 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
  Process: 3080 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
 Main PID: 3095 (nginx)
    Tasks: 2 (limit: 507)
   CGroup: /system.slice/nginx.service
           ├─3095 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
           └─3097 nginx: worker process
```

Here's our site structure as per required domins. You will always be able to have a specific location for each website and you can manage each of them individually using Nginx server blocks. As per this tutorial this is the struture I have used.

``` bash
/var/www/
├── stackpartner.com
│   └── public_html
│   └── cache
│   └── logs
├── hostingexplorer.com
│   └── public_html
│   └── cache
│   └── logs
├── wpblogsetup.com
│   └── public_html
│   └── cache
│   └── logs
```
