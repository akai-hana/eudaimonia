#!/bin/sh
# add any unregistered git repos as submodules

# palette
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
RESET='\033[0m'

cd ~/eudaimonia || exit 1

printf "${CYAN}==> checking for any unregistered submodules...${RESET}\n"

for DIR in */; do
    DIR="${DIR%/}"
    
    # skip if already a submodule
    if git config -f .gitmodules "submodule.$DIR.path" >/dev/null 2>&1; then
        continue
    fi
    
    # skip if not a git repo
    if [ ! -d "$DIR/.git" ] && [ ! -f "$DIR/.git" ]; then
        continue
    fi
    
    # get remote URL and add as submodule
    cd "$DIR"
    REMOTE=$(git config --get REMOTE.origin.url)
    cd ..
    
    if [ -n "$REMOTE" ]; then
        printf "${YELLOW}-> adding '${DIR}' as an eudaimonia submodule...${RESET}\n"
        git rm --cached -r "$DIR" 2>/dev/null
        git submodule add -f "$REMOTE" "$DIR"
    fi
done

printf "\n${GREEN}DONE!${RESET}\n"
