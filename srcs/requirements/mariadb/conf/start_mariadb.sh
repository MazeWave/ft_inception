#!/bin/sh

# Initialize MariaDB
echo "Initializing MariaDB..."
mysql_install_db --user=mysql --datadir=/var/lib/mysql

mysqld --datadir=/var/lib/mysql --skip-networking --user=mysql &
sleep 5
echo "MariaDB initialized "

# Check if MariaDB is working
echo "Waiting for MariaDB to start..."
i=0
until mysqladmin ping --silent
do
    sleep 1
    if [ $i -gt 10 ]
    then
        echo "Mariadb did not start ! Aborting..."
        exit 1
    fi
    i=$((i + 1))
done
echo "MariaDB started"

# Create databse
echo "Creating database..."
mysql -e "FLUSH PRIVILEGES;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

mysql -p"${SQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -p"${SQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "Database created"

# Restart mariadb
echo "Restarting MariaDB..."
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
exec mysqld_safe --user=mysql