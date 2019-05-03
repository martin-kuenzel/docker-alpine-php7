FROM alpine:edge

RUN   apk add -U --progress --no-cache apache2 php7 php7-curl php7-xml php7-xmlrpc php7-ssh2 php7-fpm php7-apache2 php7-simplexml php7-dom php7-sockets php7-json php7-ssh2 rsync &&   rm -f /var/cache/apk/* &&   mkdir -p /run/apache2 &&   echo "ServerName html">>/etc/apache2/httpd.conf &&   echo "AddType application/x-httpd-php .php" >> /etc/apache2/httpd.conf &&   echo "AddType application/x-httpd-phps .phps" >> /etc/apache2/httpd.conf &&   echo "AddType application/x-httpd-php3 .php3 .phtml" >> /etc/apache2/httpd.conf &&   echo "AddType application/x-httpd-php .html" >> /etc/apache2/httpd.conf 

EXPOSE 80

ADD custom_config/bin /usr/local/bin

CMD (  chmod 500 -R "/usr/local/bin";  for i in $( find /usr/local/bin/services -type f ); do   ( ( "$i" >/dev/null 2>&1 ) & );  done;   chown -R apache:apache /var/www/localhost/htdocs;  chown -R apache:apache /var/www/localhost/htdocs/.cache/*.xml &&  chmod -R 775 /var/www/localhost/htdocs/.cache/*.xml;  /usr/sbin/httpd -D FOREGROUND; )
