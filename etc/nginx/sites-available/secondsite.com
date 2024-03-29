fastcgi_cache_path /var/www/secondsite.com/cache levels=1:2 keys_zone=SECONDSITE.com:100m inactive=60m;

server {
	
	listen 443 ssl http2;
	listen [::]:443 ssl http2;
	server_name www.secondsite.com;

	ssl_certificate /etc/letsencrypt/live/secondsite.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/secondsite.com/privkey.pem;

#	access_log /var/www/secondsite.com/logs/access.log;
#	error_log  /var/www/secondsite.com/logs/error.log;

	root /var/www/secondsite.com/public_html;
	index index.php;

	set $skip_cache 0;

	# POST requests and urls with a query string should always go to PHP
	if ($request_method = POST) {
		set $skip_cache 1;
	}

	if ($query_string != "") {
		set $skip_cache 1;
	}

	# Don’t cache uris containing the following segments
	if ($request_uri ~* "/wp-admin/|/xmlrpc.php|wp-.*.php|/feed/|index.php|sitemap(_index)?.xml") {
		set $skip_cache 1;
	}

	# Don’t use the cache for logged in users or recent commenters
	if ($http_cookie ~* "comment_author|wordpress_[a-f0-9]+|wp-postpass|wordpress_no_cache|wordpress_logged_in") {
		set $skip_cache 1;
	}

	location / {
		try_files $uri $uri/ /index.php?$args;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;

		fastcgi_cache_bypass $skip_cache;
		fastcgi_no_cache $skip_cache;
		fastcgi_cache secondsite.com;
		fastcgi_cache_valid 60m;
	}

	location ~* \.(css|js|ico|gif|jpe?g|png|svg|eot|otf|woff|woff2|ttf|ogg)$ {
		expires 1y;
		add_header Cache-Control "public";
	}

}

server {
	listen 80;
	listen [::]:80;
	server_name secondsite.com www.secondsite.com;

	return 301 https://www.$server_name$request_uri;
}
