#!/bin/bash

echo '-----------------------'
echo "filemanager user =>  ${FILEMANAGERUSER:-'testuser'}"
echo "filemanager pass => ${FILEMANAGERPASSWORD:-'testpassword'}"
echo '------------------------'
replace HOSTID ${HOSTID:-'_1'} -- /usr/share/pbn/apache2.conf
replace FILEMANAGERUSER ${FILEMANAGERUSER:-'testuser'} -- /usr/share/pbn/filemanager/config/.htusers.php
replace FILEMANAGERPASSWORD $(echo -n ${FILEMANAGERPASSWORD:-'testpassword'} | md5sum | awk '{print $1}') -- /usr/share/pbn/filemanager/config/.htusers.php
chown -R  www-data:www-data /var/www/html

echo "enjoy!"
echo "========================================================================"

