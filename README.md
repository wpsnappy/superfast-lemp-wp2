# superfast-lemp-wp

#### Initial Server Setup

This section was taken from [Digitalocean](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04/) guide and it just get the job done.

Log into your server
```
$ ssh root@your_server_ip
```

Add new user from here
```
$ adduser tharindu
```

Add newly created user into group of sudo
```
$ usermod -aG sudo tharindu
```

#### Install Nxinx

```
sudo apt-get install nginx -y
sudo apt-get update && apt-get upgrade
```

#### Install PerconaDB

```
wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
dpkg -i percona-release_latest.bionic_all.deb
apt-get update && apt-get upgrade
apt-get install percona-server-server-5.7 -q -y
```

#### Install PHP7.2 and Modules

```
wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
dpkg -i percona-release_latest.bionic_all.deb
apt-get update && apt-get upgrade
apt-get install percona-server-server-5.7 -q -y
```

#### Install PerconaDB

```
wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
dpkg -i percona-release_latest.bionic_all.deb
apt-get update && apt-get upgrade
apt-get install percona-server-server-5.7 -q -y
```
