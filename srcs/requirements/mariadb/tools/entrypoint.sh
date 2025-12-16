#!/bin/sh

export DB_NAME="$(cat /run/secrets/db_name)"
export DB_USER="$(cat /run/secrets/db_user)"
export DB_PASSWORD="$(cat /run/secrets/db_password)"

echo "Entrypoint script... Checking data dir from env : $MARIADB_DATA_DIR"

if [ ! -f "$MARIADB_DATA_DIR/ibdata1" ]; then
	echo "MariaDB not initialized. Setting up..."
	mariadb-install-db --user mysql --datadir=$MARIADB_DATA_DIR --defaults-file=/etc/mysql/mariadb.conf.d/mariadb-server.cnf
	wait $!
	echo "MariaDB successfully initialized !"
else
	echo "MariaDB already initialized. Starting..."
	exec mariadb &
	wait $!
	exit 1
fi
#mariadb-install-db
#mariadb
