server {
    listen 80;
    listen [::]:80;

    # TODO: This should be your server name.
    server_name events-spa.xiaohulaoer.com;

    root /home/angela/events-spa/web-ui/build	

    location / {
        try_files $uri /index.html;
    }

    location /api {
        proxy_pass http://localhost:4356;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";	 	 
    }
}
