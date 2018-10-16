fastcgi_cache_path /var/www/firstsite.com/cache levels=1:2 keys_zone=FIRSTSITE:100m inactive=60m;

server {
	listen 443 ssl http2;
	listen [::]:443 ssl http2;
	server_name www.firstsite.com;

	ssl_certificate /etc/letsencrypt/live/firstsite.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/firstsite.com/privkey.pem;
	
	access_log /var/www/firstsite.com/logs/access.log;
	error_log /var/www/firstsite.com/logs/error.log;

	root /var/www/firstsite.com/public_html;

	index index.php;

	include global/restrictions.conf;
	include global/cache-rules.conf;

	location / {
		try_files $uri $uri/ /index.php?$args;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

		fastcgi_cache_bypass $no_cache;
		fastcgi_no_cache $no_cache;
		fastcgi_cache FIRSTSITE;
		fastcgi_cache_valid 200 60m;
	}

	location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
		expires max;
		log_not_found off;
	}
}

server {
	listen 80;
	listen [::]:80;
	server_name firstsite.com www.firstsite.com;

	ssl_certificate /etc/letsencrypt/live/firstsite.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/firstsite.com/privkey.pem;

	return 301 https://www.firstsite.com$request_uri;
}
