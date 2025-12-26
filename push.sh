#!/bin/sh
# pushes changes to all repos inside the dir

# palette
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
RESET='\033[0m'

cd ~/eudaimonia || exit 1

# Starting notification
notify-send "🔄 Eudaimonia Sync" "Starting sync of all submodules..." -u normal

printf "${CYAN}==> syncing all submodules...${RESET}\n"

# loop and push all sub-modules
for DIR in */; do
    DIR="${DIR%/}"
    cd "$DIR" || continue
    if [ -d .git ] || [ -f .git ]; then
        printf "${YELLOW}-> syncing ${DIR}...${RESET}\n"
        
        # Notify for each submodule
        notify-send "📦 Syncing" "$DIR" -u low -t 3000
        
        git add .
        git commit -m "automated sync" >/dev/null 2>&1
        git push
    fi
    cd ..
done

# push eudaimonia
cd ~/eudaimonia || exit 1
printf "${CYAN}==> syncing eudaimonia meta-repository...${RESET}\n"

notify-send "📦 Syncing" "eudaimonia meta-repository" -u low -t 3000

git add .
git commit -m "automated sync" >/dev/null 2>&1
git push

printf "\n${GREEN}DONE!${RESET}\n"

# Completion notification
notify-send "✅ Eudaimonia Sync" "All repositories synced successfully!" -u normal``
