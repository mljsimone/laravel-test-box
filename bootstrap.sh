#!/bin/bash

function bootstrap {
  echo Updating packages..
  sudo apt-get update > /dev/null

  echo Upgrading packages..
  sudo apt-get upgrade > /dev/null

  echo Installing dependencies 1/3..
  sudo apt-get install -y git nginx python-software-properties > /dev/null
  sudo cat /vagrant/nginx.conf > /etc/nginx/sites-available/default
  sudo service nginx start > /dev/null

  echo Adding andrej/php5 apt repository..
  sudo add-apt-repository ppa:ondrej/php5 > /dev/null

  echo Updating packages..
  sudo apt-get update > /dev/null

  echo Installing dependencies 2/3..
  sudo apt-get install -y php5-cli php5-fpm php5-mcrypt > /dev/null

  echo Installing dependencies 3/3..
  wget -q -O - https://getcomposer.org/installer | php > /dev/null
  sudo mv composer.phar /usr/local/bin/composer
  
  sudo mkdir /var/www
  sudo chown vagrant:vagrant /var/www
}

function final_steps {
  echo
  echo Your box is almost ready!
  echo Run the following commands to finish the setup:
  echo vagrant ssh
  echo git clone http://github.com/trustedid/laraTest /var/www
  echo chmod 777 -R /var/www/app/storage
  echo composer install -d /var/www
}

if [ ! -e /vagrant/.lock ]; then
  touch /vagrant/.lock
  
  bootstrap
  final_steps
fi
