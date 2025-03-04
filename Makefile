# Define colors
RESET		= \033[0m
WHITE		= \033[37m

BOLD		= \033[1m
UNDERLINE	= \033[4m

RED			= \033[31m
GREEN		= \033[32m
YELLOW		= \033[33m
BLUE		= \033[34m
MAGENTA		= \033[35m
CYAN		= \033[36m

NGINX_PATH			:= ./scrs/requirements/nginx
MARIADB_PATH		:= ./scrs/requirements/mariadb
WORDPRESS_PATH		:= ./scrs/requirements/wordpress

clean:
	docker system prune -fa

# fclean:
# 	docker system prune -fa
# 	docker 

build_nginx:
	docker build $(NGINX_PATH) -t nginx

run_nginx_t:
	docker run -p 443:443 -it --entrypoint /bin/sh nginx

run_nginx:
	docker run -p 443:443 --entrypoint /bin/sh nginx

build_mariadb:
	docker build $(MARIADB_PATH) -t mariadb

run_mariadb_t:
	docker run -it --entrypoint /bin/sh mariadb

run_mariadb:
	docker run --entrypoint /bin/sh mariadb

build_wordpress:
	docker build $(WORDPRESS_PATH) -t nginx

run_wordpress_t:
	docker run -p 9000:9000 -it --entrypoint /bin/sh wordpress

run_wordpress:
	docker run -p 9000:9000  --entrypoint /bin/sh wordpress

mariadb: clean build_mariadb run_mariadb_t

nginx: clean build_nginx run_nginx_t

wordpress: clean build_wordpress run_wordpress_t

all: clean build_nginx build_mariadb run_nginx run_mariadb