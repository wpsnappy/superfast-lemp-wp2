# superfast-lemp-wp

## AUTOMATIC INSTALLATION
```
curl https://github.com/tharindutpk/superfast-lemp-wp/install.sh
```

## MANUAL INSTALLATION

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
