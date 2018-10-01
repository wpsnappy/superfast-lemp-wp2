# Superfast LEMP-WP Stack<!-- omit in toc -->

## Table of Contents<!-- omit in toc -->

- [Introduction](#introduction)
- [Components](#components)
- [Initial Server Setup](#initial-server-setup)
  - [Login to the Server](#login-to-the-server)
  - [Create User with Superuser Privileges](#create-user-with-superuser-privileges)
  - [Update Ubuntu](#update-ubuntu)
- [Set up Firewall](#set-up-firewall)

## Introduction

WordPress itself has conqured 30% of it's marketplace. WordPress was made as a multi purpose CMS platform where most people would find most features not necessary.

## Components

- [Ubuntu](#) ```18.04 x64```
- [Nginx](#) ```1.14.1```
- [PerconaDB](#) ```5.7```
- [PHP](#) ```7.2-fpm```
- [Redis](#)
- [Fail2ban](#) ```0.9.7```
- [Certbot](#) ```0.28.0```
- [Postfix](#) ```3.3.1```

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

Login to the server using your ip addess. Replace ```root``` with your name and ```178.128.156.148``` with your ip address.

``` bash
$ ssh root@178.128.156.148
```

### Create User with Superuser Privileges

The default root user is the administrative user in a Linux environment that has superuser privileges and you are discouraged from using it on a regular basis. For that reason, it is highly recommended that you set up an alternative account under your own name and assign it superuser privileges.

In this example we are going to use the ```adduser``` command to add a new user called **tharindu**. The ```sudo``` command at the beginning means  “superuser do!” and tells Linux to run the ensuing command with elevated superuser privileges, otherwise you may get an access denied error.

Add a new non-root sudo user. Replaces ```tharindu``` with your preferred username.

``` bash
$ adduser tharindu
```

Once the new user is created, give it superuser privileges using the ```usermod``` command. The ```-aG``` parameter means append to Group, and the name of the superuser group is ```sudo```.

``` bash
$ usermod -aG sudo tharindu
```

We can now switch to our new account john using the su command (substitute user).

``` bash
$ sudo su - tharindu
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
$ sudo apt update && sudo apt upgrade
```

Once updated, you may need to reboot the server:

``` bash
$ sudo reboot
```

## Set up Firewall
