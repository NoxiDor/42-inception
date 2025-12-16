#!/bin/sh

export DB_NAME="$(cat /run/secrets/db_name)"
export DB_USER="$(cat /run/secrets/db_user)"
export DB_PASSWORD="$(cat /run/secrets/db_password)"

mkdir -p "$MARIADB_DATA_DIR" /run/mysqld /var/log/mariadb
chown -R mysql:mysql "$MARIADB_DATA_DIR" /run/mysqld /var/log/mariadb

echo "Entrypoint script... Checking data dir from env : $MARIADB_DATA_DIR"

if [ ! -f "$MARIADB_DATA_DIR/ibdata1" ]; then
	echo "MariaDB not initialized. Setting up..."
	mariadb-install-db --user mysql --datadir=$MARIADB_DATA_DIR
	wait $!
	echo "MariaDB successfully initialized !"
else
	echo "MariaDB already initialized. Starting..."
	#cd '/usr' ; /usr/bin/mariadbd-safe --datadir=$MARIADB_DATA_DIR &
	exec mariadbd --user mysql --init-file /tmp/init.sql --datadir=$MARIADB_DATA_DIR --port 3306 --bind-address 0.0.0.0
	#wait $!
	exit 1
fi
#mariadb-install-db
#mariadb
