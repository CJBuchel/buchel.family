#!/bin/sh

# Install Nginx & Passenger
echo "Installing nginx & Passenger"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update
sudo apt-get install -y nginx-extras libnginx-mod-http-passenger
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
sudo ls /etc/nginx/conf.d/mod-http-passenger.conf

# Replace line in passenger.conf to point to ruby
sudo sed -i '/passenger_ruby/c\passenger_ruby ~/.rbenv/shims/ruby;' /etc/nginx/conf.d/mod-http-passenger.conf

# Setting up nginx using template
sudo service nginx start
sudo rm /etc/nginx/sites-enabled/default
sudo cp ~/buchel.family/nginxTemplate /etc/nginx/sites-enabled/buchel.family

# logjam prevention
( cd ~/; openssl dhparam -out dhparams.pem 2048 )

# Setting up letsencrypt
echo "SSL"
sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-nginx

sudo nginx -t
sudo systemctl reload nginx

sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'

sudo certbot --nginx -d buchel.family -d dev.buchel.family

# Check auto renew
sudo certbot renew --dry-run

sudo nginx -s reload
sudo service nginx reload

sudo chown -R www-data:www-data .