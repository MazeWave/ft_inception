FROM alpine:3.20.0

# Intall mariadb and create necessaries
# directories to store database
RUN apk update
RUN apk add mariadb mariadb-client su-exec

RUN mkdir -p /var/lib/mysql
RUN mkdir -p /usr/var/lib/mysql
RUN mkdir -p /run/mysqld

RUN chown -R mysql:mysql /var/lib/mysql
RUN chown -R mysql:mysql /usr/var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld


# Create our database
# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
RUN mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Exec en non root
# USER mysql

# Allow mariadb daemon to start when docker start
# RUN rc-update add mariadb default

# Start mariadb daemon
COPY conf/start_mariadb.sh /var/lib/mysql/start_mariadb.sh
RUN chmod 755 /var/lib/mysql/start_mariadb.sh
# RUN mysqld --datadir=/var/lib/mysql --user=mysql
ENTRYPOINT [ "/var/lib/mysql/start_mariadb.sh" ]

# RUN mysql_secure_installation