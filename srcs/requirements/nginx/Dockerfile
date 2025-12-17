FROM alpine:3.22.2

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /run/nginx

RUN adduser -D -g 'www' www
RUN chown -R www:www /var/lib/nginx

RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
