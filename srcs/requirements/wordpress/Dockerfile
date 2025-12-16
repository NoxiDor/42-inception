FROM alpine:3.22.2

RUN apk update && apk add --no-cache \
	php84 \
	php84-fpm \
	php84-mysqli \
	php84-pdo_mysql \
	php84-gd \
	php84-mbstring \
	php84-curl \
	php84-xml \
	php84-zip \
	php84-exif \
	php84-opcache \
	wget unzip

#ADD conf/php-fpm.conf /etc/php84/

COPY ./conf/www.conf /etc/php84/php-fpm.d/www.conf

RUN mkdir -p /var/www
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz
RUN tar -xzf /tmp/wordpress.tar.gz -C /var/www/
RUN mv /var/www/wordpress /var/www/html
RUN rm -rf /tmp/wordpress.tar.gz

#RUN adduser -D -g 'www-data' www-data

#RUN cd /var/www/html/
#RUN mv wp-config-sample.php wp-config.php
#RUN chown -R www-data:www-data /var/www/html

COPY ./tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
