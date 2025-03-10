FROM alpine:3.20.0
EXPOSE 9000

# Install required packages and dependencies
RUN apk update
RUN apk add --no-cache \
    wget \
    php83 \
    php83-fpm \
    php83-mysqli \
    php-phar \
    php83-iconv \
    mariadb-client \
    -q

# Install wordpress using wget
RUN mkdir -p /var/www
RUN chown -R root:root /var/www

# Configure wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod 755 wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
RUN rm -rf /var/www/html/wp-config-sample.php

# Configure php-fpm
COPY /conf/www.conf /etc/php83/php-fpm.d/www.conf

# Start wordpress
COPY conf/auto_config.sh /
RUN chmod 755 /auto_config.sh
CMD [ "/auto_config.sh" ]
