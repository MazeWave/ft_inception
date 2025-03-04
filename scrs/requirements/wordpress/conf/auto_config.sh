#!/bin/sh

sleep 10

if [ ! -f "/var/www/wordpress/wp-config.php" ];
then
    /usr/local/bin/wp/wp config create \
        --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path="/var/www/wordpress"
    /usr/local/bin/wp/wp core install
fi

exec php-fpm83 -F  # Start PHP-FPM