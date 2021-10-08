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
yum install -y php php-mysql 

echo "@@@@@Restarting httpd@@@@@"
systemctl restart httpd.service

yum info-php-fpm
yum install -y phpfpm
cd /var/www/html
cat > info.php <<- EOF
<?php phpinfo(); ?>
EOF

echo "@@@@@Installing mariadb@@@@@"
yum install -y mariadb-server mariadb 

echo "@@@@@Starting mariadb@@@@@"
systemctl start mariadb

echo "@@@@@Installation of mysql securities@@@@@"
mysql_secure_installation <<EOF

y
Santos13
Santos13
y
y
y
y
EOF

echo "@@@@@@Enabling mariadb upon starup@@@@@"
systemctl enable mariadb 

password=Santos13

echo "@@@@@Connecting to mariadb@@@@@"
mysqladmin -u root -p$password version

echo "CREATE DATABASE wordpress; CREATE USER wordpressuser@localhost IDENTIFIED by 'Santos13'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED by 'Santos13'; FLUSH PRIVILEGES;" | mysql -u root -p$password
echo "success"

echo "@@@@@Installing php-gd@@@@@"
yum install -y php-gd

echo "@@@@@Restarting httpd@@@@@"
systemctl restart httpd.service

echo "@@@@@Installing wget@@@@@"
yum install -y wget

echo "@@@@@Downloading wordpress from the website@@@@@"
wget http://wordpress.org/latest.tar.gz

echo "@@@@@Extracting the WordPress directory@@@@@"
tar xzvf latest.tar.gz

echo "@@@@@Installing rsync@@@@@"
yum install -y rsync

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

echo "@@@@@Editing the database account@@@@@"
cd /var/www/html/
sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/wordpressuser/g' wp-config.php
sed -i 's/password_here/Santos13/g' wp-config.php

echo "@@@@@Installing new version@@@@@"
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm

echo "@@@@@Installing utlis@@@@@"
yum install -y yum-utils

echo "@@@@@Enabling remi-php56@@@@@"
yum-config-manager --enable remi-php56 

echo "@@@@@Installing php files@@@@@"
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

echo "@@@@@Restarting httpd@@@@@"
systemctl restart httpd.service


echo "@@@@@@Thank You For Installing Lampstack and Wordpress@@@@@@"