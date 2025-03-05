# Paths
COMPOSE_PATH		:= ./scrs/
NGINX_PATH			:= ./scrs/requirements/nginx
MARIADB_PATH		:= ./scrs/requirements/mariadb
WORDPRESS_PATH		:= ./scrs/requirements/wordpress

# fclean:
# 	docker system prune -fa
# 	docker 

# build_nginx:
# 	docker build $(NGINX_PATH) -t nginx

# run_nginx_t:
# 	docker run -p 443:443 -it --entrypoint /bin/sh --name nginx nginx

# run_nginx:
# 	docker run -dit -p 443:443 --entrypoint /bin/sh --name nginx nginx

# build_mariadb:
# 	docker build $(MARIADB_PATH) -t mariadb

# run_mariadb_t:
# 	docker run -it --entrypoint /bin/sh --name mariadb mariadb

# run_mariadb:
# 	docker run -dit --entrypoint /bin/sh --name mariadb mariadb

# build_wordpress:
# 	docker build $(WORDPRESS_PATH) -t wordpress

# run_wordpress_t:
# 	docker run -p 9000:9000 -it --entrypoint /bin/sh --name wordpress wordpress
# 	# docker exec -it wordpress sh

# run_wordpress:
# 	docker run -dit -p 9000:9000 --entrypoint /bin/sh --name wordpress wordpress
# 	# docker exec wordpress sh

# # Manage dockers
# stop_all:
# 	@if docker ps --format '{{.Names}}' | grep -wq nginx; then docker stop nginx; else echo "nginx is not running"; fi
# 	@if docker ps --format '{{.Names}}' | grep -wq mariadb; then docker stop mariadb; else echo "mariadb is not running"; fi
# 	@if docker ps --format '{{.Names}}' | grep -wq wordpress; then docker stop wordpress; else echo "wordpress is not running"; fi

# start_all:
# 	@if ! docker ps --format '{{.Names}}' | grep -wq nginx; then $(MAKE) nginx; else echo "nginx already running"; fi
# 	@if ! docker ps --format '{{.Names}}' | grep -wq mariadb; then $(MAKE) mariadb; else echo "mariadb already running"; fi
# 	@if ! docker ps --format '{{.Names}}' | grep -wq wordpress; then $(MAKE) wordpress; else echo "wordpress already running"; fi

# restart_all: stop_all start_all

# # Starts detached dockers
# mariadb: clean build_mariadb run_mariadb

# nginx: clean build_nginx run_nginx

# wordpress: clean build_wordpress run_wordpress

# all: stop_all clean build_nginx build_mariadb build_wordpress run_nginx run_mariadb run_wordpress

clean:
	docker system prune -fa

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

# reset: clean
# 	docker rm nginx
# 	docker rm mariadb
# 	docker rm wordpress

all: stop start