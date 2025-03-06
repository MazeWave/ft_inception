#!/bin/sh

sleep 5

echo "Waiting for MariaDB to start..."
while ! mysqladmin ping -h "mariadb" --silent;
do
    sleep 1
done
echo "MariaDB is up"

echo "Wordpress setup..."
if [ ! -f "/var/www/wordpress/wp-config.php" ];
then
    # TODO FIX PERMISSION FOR /usr/local/bin/wp COMMAND
    /usr/local/bin/wp config create \
        --allow-root \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost=mariadb:3306 \
        --dbcharset="utf8" \
        --dbcollate="utf8_general_ci" \
        --path="/var/www/wordpress"
    /usr/local/bin/wp core install \
        --url="$DOMAIN_NAME" \
        --title="inception" \
        --admin_user="$ADMIN_USER" \
        --admin_password="ADMIN_PASSWORD" \
        --skip-email
        # --admin_email="$ADMIN_EMAIL" \
    /usr/local/bin/wp create user \
        "$EVAL_USER" \
        "$EVAL_EMAIL" \
        --user_pass="$SQL_PASSWORD" \
        --role=author \
fi
echo "Wordpress setup completed"

# mkdir -p /run/php
# sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php83/php-fpm.d/www.conf

echo "Starting php-fpm83..."
exec php-fpm83 -F -R # Start PHP-FPM