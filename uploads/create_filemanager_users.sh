#!/bin/bash

echo '-----------------------'
echo "filemanager user =>  ${FILEMANAGERUSER:-'testuser'}"
echo "filemanager pass => ${FILEMANAGERPASSWORD:-'testpassword'}"
echo '------------------------'
sed -i "s/HOSTID/${HOSTID:-'_1'}/" /usr/share/pbn/apache2.conf
sed -i "s/FILEMANAGERUSER/${FILEMANAGERUSER:-'testuser'}/" /usr/share/pbn/filemanager/config/.htusers.php
sed -i "s/FILEMANAGERPASSWORD/$(echo -n ${FILEMANAGERPASSWORD:-'testpassword'} | md5sum | awk '{print $1}')/" /usr/share/pbn/filemanager/config/.htusers.php
  
chown -R  www-data:www-data /var/www/html

echo "enjoy!"
echo "========================================================================"

