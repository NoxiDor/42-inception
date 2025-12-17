#!/bin/sh

export WP_DIR="/var/www/html"

export DB_HOST="db"
export DB_PORT="3306"
export DB_NAME="$(cat /run/secrets/db_name)"
export DB_USER="$(cat /run/secrets/db_user)"
export DB_PASSWORD="$(cat /run/secrets/db_password)"

export WP_USER="$(cat /run/secrets/wp_user)"
export WP_PASSWORD="$(cat /run/secrets/wp_password)"
export WP_EMAIL="$(cat /run/secrets/wp_email)"

echo "Waiting for MariaDB at $DB_HOST:$DB_PORT..."

until nc -z "$DB_HOST" "$DB_PORT"; do
	sleep 1
done

echo "MariaDB is ready"

if [ ! -f "$WP_DIR/wp-config.php" ]; then
	echo "Wordpress config does not exit.. Creating"
	cat > "$WP_DIR/wp-config.php" <<EOF
<?php
define('DB_NAME', '${DB_NAME}');
define('DB_USER', '${DB_USER}');
define('DB_PASSWORD', '${DB_PASSWORD}');
define('DB_HOST', '${DB_HOST}:${DB_PORT}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

\$table_prefix = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
EOF

	echo "wp-config.php created"
	echo "Wordpress not initialized... running scripts"
	cd /tmp
	curl -sS -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	if ! wp core is-installed --allow-root --path="$WP_DIR"; then
    		wp core install \
        	--allow-root \
        	--path="$WP_DIR" \
        	--url="$DOMAIN_NAME" \
        	--title="Inception" \
        	--admin_user="$WP_USER" \
        	--admin_password="$WP_PASSWORD" \
        	--admin_email="$WP_EMAIL"

    		#wp user create \
        	#--allow-root \
        	#"$WP_USER" "$WP_USER_EMAIL" \
        	#--user_pass="$WP_USER_PASSWORD" \
        	#--role=author
		echo "OK!"
	fi
	rm -f /var/www/html/xmlrpc.php
	rm -rf /var/www/html/wp-config-sample.php
fi


echo "Wordpress already installed: Starting..."

exec php-fpm84 -F
