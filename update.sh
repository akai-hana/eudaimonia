#!/bin/sh

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
RESET='\033[0m'

cd ~/eudaimonia || exit 1

printf "${CYAN}==> Checking for unregistered submodules...${RESET}\n"

# Add any unregistered git repos as submodules
for dir in */; do
    dir="${dir%/}"
    
    # Skip if already a submodule
    if git config -f .gitmodules "submodule.$dir.path" >/dev/null 2>&1; then
        continue
    fi
    
    # Skip if not a git repo
    if [ ! -d "$dir/.git" ] && [ ! -f "$dir/.git" ]; then
        continue
    fi
    
    # Get remote URL and add as submodule
    cd "$dir"
    remote=$(git config --get remote.origin.url)
    cd ..
    
    if [ -n "$remote" ]; then
        printf "${YELLOW}-> Adding '${dir}' as submodule${RESET}\n"
        git rm --cached -r "$dir" 2>/dev/null
        git submodule add -f "$remote" "$dir"
    fi
done

# Update all submodules
printf "${CYAN}==> Updating all submodules...${RESET}\n"
git submodule update --init --recursive

printf "${CYAN}==> Checking out main/master branches...${RESET}\n"
git submodule foreach 'git checkout main || git checkout master'

printf "\n${GREEN}Done!${RESET}\n"
