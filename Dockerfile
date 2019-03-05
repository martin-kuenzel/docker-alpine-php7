# x86 compatible
FROM alpine:edge
# rpi compatible
#FROM arm32v6/alpine:edge

RUN apk add -U --progress --no-cache apache2 php7 php7-curl php7-xml php7-xmlrpc php7-ssh2 php7-fpm php7-apache2 php7-simplexml php7-dom php7-sockets php7-json php7-ssh2 && \

rm -f /var/cache/apk/* && \
mkdir -p /run/apache2 && \
echo "ServerName html">>/etc/apache2/httpd.conf && \
echo "AddType application/x-httpd-php .php" >> /etc/apache2/httpd.conf && \
echo "AddType application/x-httpd-phps .phps" >> /etc/apache2/httpd.conf && \
echo "AddType application/x-httpd-php3 .php3 .phtml" >> /etc/apache2/httpd.conf && \
echo "AddType application/x-httpd-php .html" >> /etc/apache2/httpd.conf 

EXPOSE 80

CMD ( \
 ( crontab -l && (echo "*/1 * * * * wget -q http://127.0.0.1/index.php?timerrun -O - >/dev/null 2>&1") )| crontab -; \
 for i in $(find /var/www/localhost/htdocs/data/.sys -name '*.xml' -type f); do \
  rm -v $(dirname $i)/../$(basename $i); cp -v $(realpath $i) "$(dirname $i)"/../; \
 done; \
 for i in $(find /var/www/localhost/htdocs/data/.cache -name '*.xml' -type f); do \
  rm -v "$(dirname $i)/../$(basename $i)"; ln -vs "$(realpath $i)" "$(dirname $i)/../"; \
 done; \
 chown -R apache:apache /var/www/localhost/htdocs; \
 chown -R apache:apache /var/www/localhost/htdocs/.cache/*.xml && \ 
 chmod -R 775 /var/www/localhost/htdocs/.cache/*.xml; \
 
 /usr/sbin/httpd -D FOREGROUND \
)

#  ln -s "/var/www/localhost/htdocs/.cache/$(basename $i)" $(realpath $(dirname "$i")); \
#CMD ["/bin/sh"]
#CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
