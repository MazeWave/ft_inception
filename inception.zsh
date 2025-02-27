#!/bin/zsh

# Basic colors
reset='\033[0m'        # Reset
bold='\033[1m'         # Bold
underline='\033[4m'    # Underline
black='\033[30m'       # Black
red='\033[31m'         # Red
green='\033[32m'       # Green
yellow='\033[33m'      # Yellow
blue='\033[34m'        # Blue
magenta='\033[35m'     # Magenta
cyan='\033[36m'        # Cyan
white='\033[37m'       # White

# Functions
start_docker_daemon()
{
    echo -n $cyan "Starting Docker Daemon..." $reset
    systemctl start docker
}

check_docker_daemon()
{
    output=$(sudo systemctl status docker | head -n 2 | tail -n 1 | cut -d ' ' -f 2)
    echo $output
    if [[ $output  == "active" ]] then
        return 1
    else
        return 0
    fi

}

# Program
echo  "---------- Updating repo ----------";
git pull;

echo  "---------- Checking Docker Daemon state ----------";
# check if the docker daemon is active, otherwise start it
if [[ check_docker_daemon -eq 1 ]] then
    start_docker_daemon
fi