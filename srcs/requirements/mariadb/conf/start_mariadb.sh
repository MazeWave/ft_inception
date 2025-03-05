#!/bin/sh
# rc-service mariadb start;

if [ ! -d "/var/lib/mysql/mysql.ibd" ];
then
    mkdir -p /var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql

    # Initialize the MariaDB database
    mysql_upgrade -u root -p
    # mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

echo "Waiting for MariaDB to start..."
until mariadb-admin ping --silent; do
    sleep 1
done


# from http://tuto.grademe.fr/inception/#mariadb
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Start mariadb
# exec mysqld_safe --user=mysql --datadir=/var/lib/mysql
exec cd '/usr' ; /usr/bin/mariadbd-safe --datadir='/var/lib/mysql'

# exec mysqld_safe --user=mysql --skip-grant-tables --datadir=/var/lib/mysql &
sleep 5  # Attendre quelques secondes
ps aux | grep mysql  # Vérifier que MariaDB tourne bien


# exec mysqld_safe
# exec su-exec mysql mariadbd --datadir=/var/lib/mysql --user=mysql