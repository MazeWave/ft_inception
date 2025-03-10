#!/bin/sh

if [ ! -e /var/lib/mysql/mysql ]
then
    # Initialize MariaDB
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Seting up database
    mysqld --datadir=/var/lib/mysql --skip-networking --user=mysql --bootstrap <<EOF
    FLUSH PRIVILEGES;
    ALTER USER 'root'@'localhost' IDENTIFIED BY "${SQL_ROOT_PASSWORD}";
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY "${SQL_PASSWORD}";
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY "${SQL_PASSWORD}";
EOF
else
    exec mysqld_safe --user=mysql
fi
