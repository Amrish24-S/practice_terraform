#!/bin/bash
sudo yum install httpd unzip wget -y
sudo systemctl start httpd
sudo systemctl enable httpd
cd /tmp/
wget https://www.tooplate.com/zip-templates/2088_big_city.zip
unzip 2088_big_city.zip
sudo cp -r 2088_big_city/* /var/www/html/
sudo systemctl restart httpd