#!/bin/bash

echo "@@@@@Installing HTTPD@@@@@"
yum install -y httpd

echo "@@@@@Starting HTTPD@@@@@"
systemctl start httpd.service

echo "@@@@@Adding Firewall Rules@@@@@"
firewall-cmd --add-port 80/tcp --permanent
firewall-cmd --add-port 443/tcp --permanent

echo "@@@@@Reloading Firewall@@@@@"
firewall-cmd --reload

echo "@@@@@Enabling httpd upon starup@@@@@"
systemctl enable httpd.service

echo "@@@@@Installing mysql@@@@@"
yum install php php-mysql

echo "@@@@@Restarting httpd@@@@@"
systemctl restart httpd.service

echo "@@@@@Installing mariadb@@@@@"
yum install mariadb-server mariadb

echo "@@@@@Starting mariadb@@@@@"
systemctl start mariadb

echo "@@@@@Installation of mysql securities@@@@@"
mysql_secure_installation

echo "@@@@@@Enabling mariadb upon starup@@@@@"
systemctl enable mariadb 

echo "@@@@@Connecting to mariadb@@@@@"
mysqladmin -u root -p version

echo "@@@@@Login in the mariadb@@@@@"
mysql -u root -p

echo "@@@@@Installing php-gd@@@@@"
yum intalll php-gd

echo "@@@@@Restarting httpd@@@@@"
systemctl restart httpd.service

echo "@@@@@Installing wget@@@@@"
yum install wget

echo "@@@@@Downloading wordpress from the website@@@@@"
wget http://wordpress.org/latest.tar.gz

echo "@@@@@Extracting the WordPress directory@@@@@"
tar xzvf latest.tar.gz

echo "@@@@@Installing rsync@@@@@"
yum install rsync

echo "@@@@@Transfering files of wordpress@@@@@"
rsync -avP wordpress/ /var/www/html/

echo "@@@@@Going to html directory@@@@@"
cd /var/www/html/

echo "@@@@@Adding a folder for wordpress for storing files@@@@@"
mkdir /var/www/html/wp-content/uploads

echo "@@@@@Granting ownership to user and groups@@@@@"
chown -R apache:apache /var/www/html/*

echo "@@@@@Coping files to make a new one@@@@@"
cp wp-config-sample.php wp-config.php

echo "@@@@@Editing the wp-config.php@@@@@"
vi wp-config.php

echo "@@@@@Installing new version@@@@@"
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

echo "@@@@@Installing utlis@@@@@"
yum install yum-utils

echo "@@@@@Enabling remi-php56@@@@@"
yum-config-manager --enable remi-php56 

echo "@@@@@Installing php files@@@@@"
yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

echo "@@@@@Restarting httpd@@@@@"
systemctl restart httpd.service