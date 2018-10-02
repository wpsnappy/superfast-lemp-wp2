# Superfast LEMP-WP Stack

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
