# Superfast LEMP-WP Stack

## Components

| Requirement | How to Check | How to Install |
| :---------- | :----------- | :------------- |
| PHP >= 5.4 | `php -v` | [php.net](http://php.net/manual/en/install.php) |
| WordPress >= 4.8 | `Admin Footer` | [wordpress.org](https://codex.wordpress.org/Installing_WordPress) |
| Genesis >= 2.6 | `Theme Page` | [studiopress.com](http://www.shareasale.com/r.cfm?b=346198&u=1459023&m=28169&urllink=&afftrack=) |
| Composer >= 1.5.0 | `composer --version` | [getcomposer.org](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx) |
| Node >= 9.10.1 | `node -v` | [nodejs.org](https://nodejs.org/) |
| NPM >= 5.6.0 | `npm -v` | [npm.js](https://www.npmjs.com/) |
| Yarn >= 0.2.x | `yarn -v` | [yarnpkg.com](https://yarnpkg.com/lang/en/docs/install/#mac-stable) |
| Gulp CLI >= 1.3.0 | `gulp -v` | [gulp.js](https://gulpjs.com/) |
| Gulp = 3.9.1 | `gulp -v` | [gulp.js](https://gulpjs.com/) |

#### Initial Server Setup

This section was taken from [Digitalocean](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04/) guide and it just get the job done.

<img src="https://github.com/tharindutpk/superfast-lemp-wp/blob/master/Screenshot/ssh-login.png" width="700px">

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
