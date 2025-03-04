FROM alpine:3.20.0

# Install required packages and dependencies
RUN apk update
RUN apk add --no-cache wget php83 php83-fpm php83-mysqli mariadb-client

# Install wordpress using wget
RUN mkdir -p /var/www
RUN chown -R root:root /var/www

RUN wget https://fr.wordpress.org/wordpress-6.7-fr_FR.tar.gz -P /var/www
RUN tar -xvf /var/www/wordpress-6.7-fr_FR.tar.gz
RUN rm -f /var/www/wordpress-6.7-fr_FR.tar.gz

# Configure php and php-fpm


# Configure wordpress

# Start wordpress
CMD [ "echo", "Hello World !-n;" ]

# Worpress pages html/php located at
# /usr/src/wordpress