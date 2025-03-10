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
        --admin_email="${ADMIN_EMAIL}"
    wp user create \
        "${EVAL_USER}" \
        "${EVAL_EMAIL}" \
        --user_pass="${EVAL_PASSWORD}" \
        --role=author
fi

chmod -R 755 /var/www/html

echo "Wordpress setup completed"

echo "Starting php-fpm83..."
exec php-fpm83 -F -R # Start PHP-FPM