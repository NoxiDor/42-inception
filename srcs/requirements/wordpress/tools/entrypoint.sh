#!/bin/sh

export WP_DIR="/var/www/html"

export DB_HOST="db"
export DB_PORT="3306"
export DB_NAME="$(cat /run/secrets/db_name)"
export DB_USER="$(cat /run/secrets/db_user)"
export DB_PASSWORD="$(cat /run/secrets/db_password)"

echo "Waiting for MariaDB at $DB_HOST:$DB_PORT..."

until nc -z "$DB_HOST" "$DB_PORT"; do
	sleep 1
done

echo "MariaDB is ready"

if [ ! -f "$WP_DIR/wp-config.php" ]; then
	echo "Wordpress config does not exit.. Creating"
#	wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost=mariadb --path="$WP_DIR"
	rm -f /var/www/html/xmlrpc.php
fi


echo "Wordpress already installed: Starting..."

exec php-fpm84 -F
