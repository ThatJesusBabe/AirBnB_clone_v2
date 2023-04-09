#!/usr/bin/env bash
<<<<<<< HEAD
# Sets up a web server for deployment of web_static.

apt-get update
apt-get install -y nginx

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Hello World" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current

chown -R ubuntu /data/
chgrp -R ubuntu /data/

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;
    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }
    location /redirect_me {
        return 301 http://cuberule.com/;
    }
    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
=======
# Prepare my webservers (web-01 & web-02)

# uncomment for easy debugging
#set -x

# colors
blue='\e[1;34m'
#brown='\e[0;33m'
green='\e[1;32m'
reset='\033[0m'

echo -e "${blue}Updating and doing some minor checks...${reset}\n"

# install nginx if not present
if [ ! -x /usr/sbin/nginx ]; then
	sudo apt-get update -y -qq && \
	     sudo apt-get install -y nginx
fi

echo -e "\n${blue}Setting up some minor stuff.${reset}\n"

# Create directories...
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared/

# create index.html for test directory
echo "Welcome to my page, Ladellstore.tech" | sudo dd status=none of=/data/web_static/releases/test/index.html

# create symbolic link
sudo ln -sf /data/web_static/releases/test /data/web_static/current

# give user ownership to directory
sudo chown -R ubuntu:ubuntu /data/

# backup default server config file
sudo cp /etc/nginx/sites-enabled/default nginx-sites-enabled_default.backup

# Set-up the content of /data/web_static/current/ to redirect
# to domain.tech/hbnb_static
sudo sed -i '37i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

sudo service nginx restart

echo -e "${green}Completed${reset}"
>>>>>>> d9bf6f52eb51ccfeb1338a9ebaa028fc54707034
