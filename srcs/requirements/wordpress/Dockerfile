FROM alpine:3.22.2

RUN apk update && apk add --no-cache \
	netcat-openbsd \
	php84 \
	php84-cli \
	php84-phar \
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
	wget unzip curl

RUN ln -s /usr/bin/php84 /usr/bin/php

COPY ./conf/www.conf /etc/php84/php-fpm.d/www.conf

RUN mkdir -p /var/www
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz
RUN tar -xzf /tmp/wordpress.tar.gz -C /var/www/
RUN mv /var/www/wordpress /var/www/html
RUN rm -rf /tmp/wordpress.tar.gz

#RUN adduser -D 'www-data'
RUN adduser -D -H -u 1000 -s /bin/bash www-data -G www-data
#RUN cd /var/www/html/
#RUN mv wp-config-sample.php wp-config.php
RUN chown -R www-data:www-data /var/www/html

COPY ./tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
