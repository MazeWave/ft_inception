# Paths
COMPOSE_PATH		:= ./scrs/
NGINX_PATH			:= ./scrs/requirements/nginx
MARIADB_PATH		:= ./scrs/requirements/mariadb
WORDPRESS_PATH		:= ./scrs/requirements/wordpress

# Rules
clean:
	docker system prune -fa --volumes

enter_nginx:
	docker exec -it nginx /bin/sh

enter_mariadb:
	docker exec -it mariadb /bin/sh

enter_wordpress:
	docker exec -it wordpress /bin/sh

build:
	cd ./srcs && docker compose up --build -d

start:
	cd ./srcs && docker compose up -d

stop:
	cd ./srcs && docker compose down

logs_mariadb:
	cd ./srcs && docker compose logs -f mariadb

logs_nginx:
	cd ./srcs && docker compose logs -f nginx

logs_wordpress:
	cd ./srcs && docker compose logs -f wordpress

# reset: clean
# 	docker rm nginx
# 	docker rm mariadb
# 	docker rm wordpress

re: stop clean build

all: stop start

# all: $(NAME)

# $(NAME): stop start