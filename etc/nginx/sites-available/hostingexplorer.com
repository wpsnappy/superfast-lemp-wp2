fastcgi_cache_path /var/www/hostingexplorer.com/cache levels=1:2 keys_zone=hostingexplorer.com:100m inactive=60m;

server {
	
	listen 443 ssl http2;
	listen [::]:443 ssl http2;

	ssl_certificate /etc/letsencrypt/live/hostingexplorer.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/hostingexplorer.com/privkey.pem;

	root /var/www/hostingexplorer.com/public_html;
	index index.php;
	server_name www.hostingexplorer.com;

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
		try_files $uri $uri/ =404;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;

		fastcgi_cache_bypass $skip_cache;
		fastcgi_no_cache $skip_cache;
		fastcgi_cache hostingexplorer.com;
		fastcgi_cache_valid 60m;
	}

}

server {
	listen 80;
	listen [::]:80;
	listen 443 ssl;
	listen [::]:443 ssl;
	server_name hostingexplorer.com;

	return 301 https://www.$server_name$request_uri;
}
