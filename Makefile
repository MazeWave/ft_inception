# Paths
COMPOSE_PATH		:= ./scrs/
NGINX_PATH			:= ./scrs/requirements/nginx
MARIADB_PATH		:= ./scrs/requirements/mariadb
WORDPRESS_PATH		:= ./scrs/requirements/wordpress

# Volumes paths
VOLUMES				:= /home/ldalmass/data
VOLUME_MDB			:= /home/ldalmass/data/mariadb
VOLUME_WP			:= /home/ldalmass/data/wordpress

# Rules
build:
	@if [ ! -d $(VOLUMES) ]; \
	then \
		mkdir /home/ldalmass/data; \
		mkdir $(VOLUME_MDB) $(VOLUME_WP); \
	fi

	@if [ ! -d $(VOLUME_MDB) ]; \
	then \
		mkdir $(VOLUME_MDB); \
	fi

	@if [ ! -d $(VOLUME_WP) ]; \
	then \
		mkdir $(VOLUME_WP); \
	fi

	cd ./srcs && docker compose up --build -d

start:
	cd ./srcs && docker compose up -d

stop:
	cd ./srcs && docker compose down

clean: stop
	docker system prune -fa

volumes_clean: stop
	docker volume rm srcs_mariadb srcs_wordpress
	docker system prune -fa --volumes
	sudo rm -rf /home/ldalmass/data
	mkdir /home/ldalmass/data
	mkdir $(VOLUME_MDB) $(VOLUME_WP)

enter_nginx:
	docker exec -it nginx /bin/sh

enter_mariadb:
	docker exec -it mariadb /bin/sh

enter_wordpress:
	docker exec -it wordpress /bin/sh

logs_mariadb:
	cd ./srcs && docker compose logs -f mariadb

logs_nginx:
	cd ./srcs && docker compose logs -f nginx

logs_wordpress:
	cd ./srcs && docker compose logs -f wordpress

re: stop build

reset: stop clean volumes_clean build

all: stop start
