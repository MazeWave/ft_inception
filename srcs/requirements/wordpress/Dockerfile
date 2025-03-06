FROM alpine:3.20.0
EXPOSE 9000

# Install required packages and dependencies
RUN apk update
RUN apk add --no-cache wget php83 php83-fpm php83-mysqli php-phar mariadb-client

# Install wordpress using wget
RUN mkdir -p /var/www
RUN chown -R root:root /var/www

RUN wget https://fr.wordpress.org/wordpress-6.7-fr_FR.tar.gz
RUN tar -xvf wordpress-6.7-fr_FR.tar.gz -C /var/www
RUN rm -f /var/www/wordpress-6.7-fr_FR.tar.gz

# Configure wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /usr/local/bin/wp
RUN mv /usr/local/bin/wp/wp-cli.phar /usr/local/bin/wp/wp
RUN chown -R root:root /usr/local/bin/wp
RUN chmod 755 /usr/local/bin/wp/wp

# Configure php-fpm
COPY /conf/www.conf /etc/php83/php-fpm.d/www.conf

# Start wordpress
COPY conf/auto_config.sh /
RUN chmod 755 /auto_config.sh
CMD [ "/auto_config.sh" ]

# Worpress pages html/php located at
# /usr/src/wordpress

# personne chaud sur inception : yenaiji