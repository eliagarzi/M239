FROM nginx

WORKDIR /usr/share/nginx/html

RUN apt update

RUN apt install curl tar

RUN apt install php-xml php-mbstring php-intl php-zip php-pear git composer

RUN php.ini 

RUN curl https://github.com/roundcube/roundcubemail/releases/download/1.5.2/roundcubemail-1.5.2-complete.tar.gz

RUN tar xzvf roundcubemail-1.5.2-complete.tar.gz

RUN rm roundcubemail-1.5.2-complete.tar.gz

RUN chown -R www-data:www-data /var/wwww/roundcube

RUN chmod 775 /var/wwww/roundcube/temp/ /var/wwww/roundcube/logs/ 



