#!/bin/sh
rc-service mariadb start;

if [ ! -d "/var/lib/mysql" ];
then
    RUN mkdir -p /var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql

    # Initialize the MariaDB database
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# from http://tuto.grademe.fr/inception/#mariadb
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Start mariadb
exec mysqld_safe
# exec su-exec mysql mariadbd --datadir=/var/lib/mysql --user=mysql