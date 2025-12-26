#!/bin/sh
# pulls/updates all submodules and checks out main branch

# palette
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
RESET='\033[0m'

printf "${CYAN}==> updating submodule list...${RESET}\n"
git submodule update --init --recursive

printf "${CYAN}==> checking out branches...${RESET}\n"
git submodule foreach 'git checkout main'

printf "\n${GREEN}DONE!${RESET}\n"
