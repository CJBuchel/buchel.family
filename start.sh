#!/bin/sh
echo "starting rails server"

echo "Yarn installer"
yarn install

echo "Installing gems"
bundle install

echo "Compiling assets for production"
rake assets:precompile


sudo service nginx start
echo "Webserver Started"