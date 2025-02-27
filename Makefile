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

clean:
	docker system prune -fa

build:
	docker build ./scrs/requirements/nginx -t nginx

run:
	docker run -p 443:443 $(USE_TERMINAL) --entrypoint /bin/sh nginx

all: build run