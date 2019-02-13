sudo apt install git
sudo apt-get update
sudo apt install nginx
sudo apt-get install -y software-properties-common

echo "PHP setup"
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt search php7.1
sudo apt install php7.1
sudo apt install php7.1-fpm
sudo apt install php7.1-mbstring
sudo apt install php7.1-curl
sudo apt install php7.1-bcmath
sudo apt install php7.1-dom
sudo apt install php7.1-gd
sudo apt install php7.1-zip
sudo apt install php7.1-xml
sudo apt install php-apcu
sudo apt-get install php7.1-mysql
sudo apt install php7.1-igbinary
sudo sudo apt install php-msgpack
sudo apt install php7.1-bcmath
sudo apt install php7.1-mcrypt
sudo apt install php7.1-redis
sudo apt install php7.1-SimpleXML
sudo apt install php7.1-xsl

echo "ShmCache install"
echo "step1: compile && install libfastcommon"
sudo apt install make
sudo apt install gcc
git clone https://github.com/happyfish100/libfastcommon
cd ./libfastcommon
sudo ./make.sh
sudo ./make.sh install

echo "step2: compile && install libshmcache"
cd ..
git clone https://github.com/happyfish100/libshmcache
cd ./libshmcache/src
make
sudo make install
cd ./tools
make
sudo make install

echo "OPTIONAL step3: compile && install libshmcache php extension"
cd ../..
cd ./php-shmcache
sudo apt install php7.1-dev
phpize
./configure
make
sudo make install
cd ../..

echo "installing supervisor"
sudo apt install supervisor

echo "installing mySQL"
sudo apt search mysql-server
sudo apt install mysql-server-5.7

echo "installing redis-server & composer"
sudo apt install redis-server
sudo apt install composer

echo "setting up xunsearch"
wget http://www.xunsearch.com/download/xunsearch-full-latest.tar.bz2
tar -xjf xunsearch-full-latest.tar.bz2
cd xunsearch-full-1.4.13/
sudo apt install g++
sudo apt-get install zlib1g-dev
sh setup.sh
./home/ubuntu/xunsearch/bin/xs-ctl.sh


echo "code"
cd /home/ubuntu
mkdir code
cd ./code
git clone https://github.com/HeyniTalk/heynitalk-api-web.git
cd ./heynitalk-api-web
composer install --prefer-dist --no-dev --no-scripts --no-interaction && composer dump-autoload --optimize;
sudo chown -R www-data:www-data /home/ubuntu/code/heynitalk-api-web;
sudo chmod -R 774 /home/ubuntu/code/heynitalk-api-web;
sudo ln -nfs /home/ubuntu/code/heynitalk-api-web/.env.development /home/ubuntu/code/heynitalk-api-web/.env;
sudo php artisan optimize;
sudo php artisan config:cache;
sudo php artisan route:cache;

echo "configure mysql"
cd ../..
sudo service mysql start
mysql -u root -p
##CREATE USER 'luosidao'@'localhost' IDENTIFIED BY 'luosiding4132';
##GRANT ALL PRIVILEGES ON *.* TO 'luosidao'@'localhost';
##quit
mysql -u luosidao -p
##CREATE DATABASE live;
##use live;
##set names utf8;
##source /home/ubuntu/db/lives.sql;
##show tables
##quit


sudo /etc/init.d/php7.1-fpm start

echo "configure api.conf"
cd /etc/nginx/conf.d
sudo vi api.conf

sudo service nginx restart

echo "admin-web"
cd /home/ubuntu/code
git clone https://github.com/HeyniTalk/heynitalk-admin-web.git
cd ./heynitalk-admin-web
sudo chown -R www-data:www-data /home/ubuntu/code/heynitalk-admin-web;
sudo chmod -R 777 /home/ubuntu/code/heynitalk-admin-web;
sudo ln -nfs /home/ubuntu/code/heynitalk-admin-web/.env.development /home/ubuntu/code/heynitalk-admin-web/.env;
composer install --prefer-dist --no-dev --no-scripts --no-interaction && composer dump-autoload --optimize;

echo "configure admin.conf"
cd /etc/nginx/conf.d
sudo vi admin.conf

sudo service nginx restart











