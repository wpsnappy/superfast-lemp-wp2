# Superfast LEMP-WP Stack<!-- omit in toc -->

## Table of Contents<!-- omit in toc -->

- [Introduction](#introduction)
- [Components](#components)
- [Initial Server Setup](#initial-server-setup)
  - [Login to the server](#login-to-the-server)
  - [Create a user with superuser privileges](#create-a-user-with-superuser-privileges)
- [Firewall](#firewall)

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

### Login to the server

Login to the server using your ip addess. Replace ```root``` with your name and ```178.128.156.148``` with your ip address.

``` bash
ssh root@178.128.156.148
```

### Create a user with superuser privileges

Add a new non-root sudo user. Replaces ```tharindu``` with your preferred username.

``` bash
adduser tharindu
```

Add newly created username into sudoers list.

``` bash
usermod -aG sudo tharindu
```

## Firewall
