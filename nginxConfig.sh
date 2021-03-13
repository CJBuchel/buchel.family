#!/bin/sh

# Install Nginx & Passenger
# echo "Installing nginx & Passenger"
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
# sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
# sudo apt-get update
# sudo apt-get install -y nginx-extras libnginx-mod-http-passenger
# if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
# sudo ls /etc/nginx/conf.d/mod-http-passenger.conf

# Install our PGP key and add HTTPS support for APT
# Install Nginx & Passenger
# echo "Installing nginx & Passenger"
read -p "Username for server e.g [cj]: " user

sudo apt-get install -y nginx
sudo apt-get install -y dirmngr gnupg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-get install -y snapd
sudo snap install core; sudo snap refresh core

# Add our APT repository
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

# Install Passenger + Nginx module
sudo apt-get install -y nginx-extras passenger
sudo apt-get install -y libnginx-mod-http-passenger

if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
if [ ! -f /etc/nginx/conf.d/mod-http-passenger.conf  ]; then 

	# Create & add default lines to file
	sudo touch /etc/nginx/conf.d/mod-http-passenger.conf
	sudo echo "passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;" | sudo tee -a /etc/nginx/conf.d/mod-http-passenger.conf
	sudo echo "passenger_ruby /usr/bin/passenger_free_ruby;" | sudo tee -a /etc/nginx/conf.d/mod-http-passenger.conf
fi

echo "Passenger Location: "
echo " "
sudo ls /etc/nginx/conf.d/mod-http-passenger.conf

# Replace line in passenger.conf to point to ruby
sudo sed -i '/passenger_ruby/c\passenger_ruby ~/.rbenv/shims/ruby;' /etc/nginx/conf.d/mod-http-passenger.conf

sudo service nginx restart

# sudo /usr/bin/passenger-config validate-install
# sudo /usr/sbin/passenger-memory-stats

# Setting up letsencrypt
echo "SSL Encryption"
# sudo add-apt-repository ppa:certbot/certbot
# sudo apt install python-certbot-nginx
# sudo apt install certbot python3-certbot-nginx
sudo service nginx stop
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx -d buchel.family -d blitzen-alpha.com
# sudo certbot --nginx

# Setting up nginx using template
sudo service nginx start
sudo rm /etc/nginx/sites-enabled/default
sudo cp nginxTemplate /etc/nginx/sites-enabled/buchel.family

# logjam prevention
sudo mkdir /var/www/dhparams/
( cd /var/www/dhparams/; openssl dhparam -out dhparams.pem 2048 )

sudo nginx -t
sudo systemctl reload nginx

sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'


# Check auto renew
sudo certbot renew --dry-run

sudo nginx -s reload
sudo service nginx reload

sudo chown -R www-data:www-data .