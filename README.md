# superfast-lemp-wp

#### Initial Server Setup

This section was taken from [Digitalocean](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04/) guide and it just get the job done.

Log into your server
```shsh
$ ssh root@your_server_ip
```

Add new user from here
```sh
$ adduser tharindu
```

Add newly created user into group of sudo
```sh
$ usermod -aG sudo tharindu
```

#### Install Nxinx

```sh
$ sudo apt-get install nginx -y
$ sudo apt-get update && apt-get upgrade
```

#### Install PerconaDB

```sh
$ wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
$ dpkg -i percona-release_latest.bionic_all.deb
$ apt-get update && apt-get upgrade
$ apt-get install percona-server-server-5.7 -q -y
```

#### Install PHP7.2 and Modules

```sh
$ wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
$ dpkg -i percona-release_latest.bionic_all.deb
$ apt-get update && apt-get upgrade
$ apt-get install percona-server-server-5.7 -q -y
```

#### Install PerconaDB

```sh
$ wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
$ dpkg -i percona-release_latest.bionic_all.deb
$ apt-get update && apt-get upgrade
$ apt-get install percona-server-server-5.7 -q -y
```
