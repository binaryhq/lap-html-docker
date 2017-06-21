FROM ubuntu:trusty
MAINTAINER Ningappa <ningappa.kamate787@gmail.com>


ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install supervisor apache2 libapache2-mod-php5  php-apc php5-mcrypt zip unzip  && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf && rm /var/www/html/index.html

RUN php5enmod mcrypt
RUN a2enmod rewrite

# Add image configuration and scripts
ADD uploads/start-apache2.sh /start-apache2.sh
ADD uploads/run.sh /run.sh
ADD uploads/create_filemanager_users.sh /create_filemanager_users.sh
RUN chmod 755 /*.sh
ADD uploads/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD uploads/apache_default /etc/apache2/sites-available/000-default.conf



#filemanager and Database admin
ADD uploads/pbn	/usr/share/pbn
RUN chmod 777 /usr/share/pbn/filemanager/config/.htusers.php && \
	echo "IncludeOptional /usr/share/pbn/apache2.conf" >> /etc/apache2/apache2.conf && \
	echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
	echo "Listen 2083" >> /etc/apache2/ports.conf

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 100M
ENV PHP_POST_MAX_SIZE 100M


EXPOSE 80 3306 2083 7890

VOLUME  ["/var/www/html" ]

CMD ["/run.sh"]
