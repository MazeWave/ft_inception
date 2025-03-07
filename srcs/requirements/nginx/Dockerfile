FROM alpine:3.20.0
EXPOSE 443

## Config and install packages
RUN apk update
RUN apk add vim -q

# Copy our conf file inside the container
COPY conf/nginx.conf /etc/nginx/nginx.conf
# COPY conf/nginx.conf /etc/nginx/http.d/nginx.conf

## generate SSL/TLS certificates
RUN mkdir -p /etc/nginx/ssl
RUN apk add openssl
RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=France/N=Nice/O=42/CN=ldalmass.42.fr/UID=ldalmass"

## nginx
RUN apk add nginx
RUN mkdir -p /var/run/nginx

## Start nginx in the container
CMD [ "nginx", "-g", "daemon off;" ]
