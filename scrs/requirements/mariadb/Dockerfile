FROM alpine:3.20.0
EXPOSE 3306

# Intall mariadb and create necessaries
# directories to store database
RUN apk update
RUN apk add --no-cache mariadb mariadb-client su-exec openrc

# RUN mkdir -p /var/lib/mysql   #done in the script
# RUN chown -R mysql:mysql /var/lib/mysql   #done in the script

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Initialize the MariaDB database
# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql #done in the script

# Copy our mariadb config file
COPY conf/my.cnf /etc/my.cnf
RUN chown -R mysql:mysql /etc/my.cnf

COPY conf/start_mariadb.sh /etc/start_mariadb.sh
RUN chmod 755 /etc/start_mariadb.sh
RUN /etc/start_mariadb.sh

# RUN mysql_secure_installation
# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Launch mariadb
USER mysql
CMD ["mysqld_safe", "--user=mysql", "--datadir=/var/lib/mysql"]