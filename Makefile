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

USE_TERMINAL	:= -it
NGINX_PATH		:= ./scrs/requirements/nginx
MARIADB_PATH	:= ./scrs/requirements/mariadb

clean:
	docker system prune -fa

# fclean:
# 	docker system prune -fa
# 	docker 

build_nginx:
	docker build $(NGINX_PATH) -t nginx

run_nginx:
	docker run -p 443:443 $(USE_TERMINAL) --entrypoint /bin/sh nginx

build_mariadb:
	docker build $(MARIADB_PATH) -t mariadb

run_mariadb:
	docker run $(USE_TERMINAL) --entrypoint /bin/sh mariadb

mariadb: clean build_mariadb run_mariadb

nginx: clean build_nginx run_nginx

all: clean build_nginx build_mariadb run_nginx run_mariadb