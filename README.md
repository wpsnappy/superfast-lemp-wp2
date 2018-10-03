# Superfast LEMP-WP Stack

```
# Document root
/var/www/hostingexplorer.com/public_html

# Cache
/var/www/hostingexplorer.com/cache

# Logs
/var/www/hostingexplorer.com/logs
```

## Initial Server Setup

``` bash
ssh root@142.93.200.70
```

``` bash
adduser tharindu
```

``` bash
usermod -aG sudo tharindu
```

``` bash
sudo su - tharindu
```

``` bash
mkdir ~/.ssh
```

``` bash
chmod 700 ~/.ssh
```

``` bash
nano ~/.ssh/authorized_keys
```

``` bash
# pbcopy < ~/.ssh/id_rsa.pub
# paste
```

``` bash
chmod 600 ~/.ssh/authorized_keys
```

Set ```PermitRootLogin yes``` to ```PermitRootLogin no``` and ```PasswordAuthentication yes``` to ```PasswordAuthentication no```.

``` bash
sudo nano /etc/ssh/sshd_config
```

``` diff
- PermitRootLogin yes
+ PermitRootLogin no

- PasswordAuthentication yes
+ PasswordAuthentication no

```

``` bash
sudo service ssh restart
```

Reboot the server

``` bash
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo reboot
```

### Install Nginx

``` bash
sudo add-apt-repository ppa:nginx/development -y
sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl status nginx

sudo apt-get install ufw
sudo ufw app list
sudo ufw allow OpenSSH 
sudo ufw allow 'Nginx Full'
sudo ufw show added
sudo ufw enable
sudo ufw status verbose
```

Open nginx conf file using this command and edit the followings.

``` bash
sudo nano /etc/nginx/nginx.conf
```

Change above files in config file

``` nginx

# I have 2 cores
worker_processes 2;

# multiply number of cores from the output of this command `ulimit -n`
worker_connections 2048;

keepalive_timeout 10;

# Add the following lines to the config file
client_body_buffer_size 128k;
client_header_buffer_size 10k;
client_max_body_size 10m;
large_client_header_buffers 4 256k;
```

``` bash
sudo apt-get install fail2ban -y
sudo service fail2ban start
```

``` bash
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install php7.2-fpm php7.2-common php7.2-mysql php7.2-xml php7.2-xmlrpc php7.2-curl php7.2-gd php7.2-imagick php7.2-cli php7.2-dev php7.2-imap php7.2-mbstring php7.2-opcache php7.2-redis php7.2-soap php7.2-zip -y
systemctl status php7.2-fpm
sudo systemctl restart nginx
```

### Useful Commands

Copy remote file content ```ssh tharindu@142.93.200.70  "cat /etc/nginx/nginx.conf"|pbcopy```
