#!/bin/sh

sleep 5

echo "Waiting for MariaDB to start..."
while ! mysqladmin ping -h "mariadb" --silent;
do
    sleep 1
done
echo "MariaDB is up"

echo "Wordpress setup..."
if [ ! -f "/wp-config.php" ];
then
    sed -i 's/memory_limit = 128M/memory_limit = 512M/' /etc/php83/php.ini
    wp core download \
        --path="/var/www/html"
    cd /var/www/html
    wp config create \
        --allow-root \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost=mariadb:3306 \
        --dbcharset="utf8" \
        --dbcollate="utf8_general_ci" \
        --path="/var/www/html"
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="inception" \
        --admin_user="${ADMIN_USER}" \
        --admin_password="${ADMIN_PASSWORD}" \
        --admin_email="${ADMIN_EMAIL}" \
        --skip-email
        # --debug
        # --admin_email=ldalmass@student.42nice.fr \
        echo "passed env email : " "${ADMIN_EMAIL}"
    wp user create \
        "${EVAL_USER}" \
        "${EVAL_EMAIL}" \
        --user_pass="${SQL_PASSWORD}" \
        --role=author
fi

echo "Wordpress setup completed"

# mkdir -p /run/php
# sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php83/php-fpm.d/www.conf

echo "Starting php-fpm83..."
exec php-fpm83 -F -R # Start PHP-FPM