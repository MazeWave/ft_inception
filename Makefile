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

# Check if Docker is active
check_docker_daemon:
	@command=$$(sudo systemctl is-active docker);
	echo $$command;
	if [ $$command != "active" ]; then
		exit 0;
	else
		exit 1;
	fi

# Start Docker daemon
start_docker_daemon:
	@echo -n "$(CYAN)Starting Docker Daemon...$(RESET)"
	@sudo systemctl start docker

# Update the repository
update_repo:
	@echo "---------- Updating repo ----------"
	@git pull

# Main target: check Docker daemon and update repo
all: update_repo check_docker_daemon
	@if [ $$? -eq 0 ]; then
		make start_docker_daemon;
	fi