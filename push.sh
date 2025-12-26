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
        
        git add .
        if git commit -m "automated sync" >/dev/null 2>&1; then
            # Changes were committed
            if git push 2>&1 | grep -q "Everything up-to-date"; then
                notify-send "📦 $DIR" "Committed but already up-to-date" -u low -t 3000
            else
                notify-send "✨ $DIR" "Changes pushed successfully" -u low -t 3000
            fi
        else
            # No changes to commit
            notify-send "✓ $DIR" "Nothing to sync" -u low -t 3000
        fi
    fi
    cd ..
done

# push eudaimonia
cd ~/eudaimonia || exit 1
printf "${CYAN}==> syncing eudaimonia meta-repository...${RESET}\n"

git add .
if git commit -m "automated sync" >/dev/null 2>&1; then
    # Changes were committed
    if git push 2>&1 | grep -q "Everything up-to-date"; then
        notify-send "📦 eudaimonia" "Committed but already up-to-date" -u low -t 3000
    else
        notify-send "✨ eudaimonia" "Meta-repository changes pushed" -u low -t 3000
    fi
else
    # No changes to commit
    notify-send "✓ eudaimonia" "Meta-repository nothing to sync" -u low -t 3000
fi

printf "\n${GREEN}DONE!${RESET}\n"

# Completion notification
notify-send "✅ Eudaimonia Sync" "All repositories synced successfully!" -u normal
