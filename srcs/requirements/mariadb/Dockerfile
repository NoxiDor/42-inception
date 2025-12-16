FROM alpine:3.22.2

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY ./tools/init.sql /tmp/init.sql
RUN chmod +x /tmp/init.sql

RUN mkdir -p /var/lib/mariadb && mkdir -p /run/mysqld &&\
	chown -R mysql:mysql /run/mysqld &&\
	chown -R mysql:mysql /var/lib/mariadb &&\
	chgrp -R mysql /var/lib/mariadb &&\
	chgrp -R mysql /run/mysqld &&\
	chmod 777 /run/mysqld

ENTRYPOINT ["/entrypoint.sh"]
