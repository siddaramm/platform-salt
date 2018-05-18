upstream websocket {
	server localhost:3123
}

server {
	listen {{port}} default_server;

	root {{ console_dir }};
	index index.html index.htm; 

	# Make site accessible from http://localhost/
	server_name localhost;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
		# Uncomment to enable naxsi on this location
		# include /etc/nginx/naxsi.rules
		proxy_pass http://127.0.0.1:3123
	}

	location /socket.io/ {
    	proxy_pass http://websocket;
    	proxy_http_version 1.1;
    	proxy_set_header Upgrade $http_upgrade;
    	proxy_set_header Connection "upgrade";
    }

    location /socket.io/socket.io.js {
    	proxy_pass http://websocket;
    }

	#error_page 500 502 503 504 /50x.html;
	#location = /50x.html {
	#	root /usr/share/nginx/html;
	#}

	# deny access to .htaccess files, if Apache's document root
	# concurs with nginx's one
	#
	#location ~ /\.ht {
	#	deny all;
	#}
}
