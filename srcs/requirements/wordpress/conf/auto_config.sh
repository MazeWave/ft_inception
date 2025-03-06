#!/bin/sh

sleep 10

echo "Waiting for MariaDB to start..."
while ! mysqladmin ping -h "mariadb" --silent;
do
    sleep 1
done

echo "MariaDB is up - proceeding with WordPress setup."

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