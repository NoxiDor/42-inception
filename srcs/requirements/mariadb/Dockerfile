FROM alpine:3.22.2

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./conf/mariadb-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
