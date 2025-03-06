#!/bin/sh

if [ ! -d "/var/lib/mysql/" ];
then
    echo "Initializing MariaDB..."
    mkdir -p /var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql

    # Initialize the MariaDB database
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "MariaDB initialized"
fi

echo "Waiting for MariaDB to start..."
until mariadb-admin ping --silent; do
    sleep 1
done
echo "MariaDB started"

# from http://tuto.grademe.fr/inception/#mariadb
mariadb -e -u root "FLUSH PRIVILEGES;"
mariadb -e -u root "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

mariadb -e -u root "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mariadb -e -u root "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mariadb -e -u root "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

mariadb-admin -u root -p$SQL_ROOT_PASSWORD shutdown

# Start mariadb
exec /usr/bin/mysql --user=mysql --console

# exec mysqld_safe