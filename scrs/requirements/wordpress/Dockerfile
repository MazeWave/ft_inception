FROM alpine:3.20.0

# Install required packages and dependencies
RUN apk update
RUN apk install wget php php-fpm php-mysql mariadb-client

# Install wordpress using wget
RUN wget https://fr.wordpress.org/wordpress-6.7-fr_FR.tar.gz -P /var/www
RUN tar -xvf /var/www/wordpress-6.7-fr_FR.tar.gz
RUN rm -f /etc/www/wordpress-6.7-fr_FR.tar.gz

# Let root own wordpress perms
RUN chown -R root:root /etc/www

# Start wordpress
CMD [ "echo", "-n;" ]