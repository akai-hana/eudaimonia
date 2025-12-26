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

# Track changes
CHANGES_SUMMARY=""
REPOS_WITH_CHANGES=""

# loop and push all sub-modules
for DIR in */; do
    DIR="${DIR%/}"
    cd "$DIR" || continue
    if [ -d .git ] || [ -f .git ]; then
        printf "${YELLOW}-> syncing ${DIR}...${RESET}\n"
        
        git add .
        
        # Check what files were changed before committing
        CHANGED_FILES=$(git diff --cached --name-only)
        
        if git commit -m "automated sync" >/dev/null 2>&1; then
            # Changes were committed
            REPOS_WITH_CHANGES="${REPOS_WITH_CHANGES}${DIR} "
            CHANGES_SUMMARY="${CHANGES_SUMMARY}\n${BOLD}${DIR}:${RESET}\n"
            
            # Add changed files to summary
            if [ -n "$CHANGED_FILES" ]; then
                echo "$CHANGED_FILES" | while read -r file; do
                    CHANGES_SUMMARY="${CHANGES_SUMMARY}  - ${file}\n"
                done
                # Store for this iteration
                TEMP_FILES=$(echo "$CHANGED_FILES" | sed 's/^/  - /' | tr '\n' ';')
                
                if git push 2>&1 | grep -q "Everything up-to-date"; then
                    notify-send "📦 $DIR" "Committed but already up-to-date" -u low -t 3000
                else
                    notify-send "✨ $DIR" "Changes pushed successfully" -u low -t 3000
                fi
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
CHANGED_FILES=$(git diff --cached --name-only)

if git commit -m "automated sync" >/dev/null 2>&1; then
    # Changes were committed
    REPOS_WITH_CHANGES="${REPOS_WITH_CHANGES}eudaimonia "
    CHANGES_SUMMARY="${CHANGES_SUMMARY}\n${BOLD}eudaimonia (meta):${RESET}\n"
    
    if [ -n "$CHANGED_FILES" ]; then
        echo "$CHANGED_FILES" | while read -r file; do
            CHANGES_SUMMARY="${CHANGES_SUMMARY}  - ${file}\n"
        done
    fi
    
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

# Display summary of changes
if [ -n "$REPOS_WITH_CHANGES" ]; then
    printf "\n${CYAN}${BOLD}==> SUMMARY OF CHANGES:${RESET}\n"
    printf "${CHANGES_SUMMARY}"
    
    # Send summary notification
    REPO_COUNT=$(echo "$REPOS_WITH_CHANGES" | wc -w)
    notify-send "✅ Eudaimonia Sync Complete" "Changes pushed in $REPO_COUNT repo(s): $REPOS_WITH_CHANGES" -u normal -t 8000
else
    printf "\n${YELLOW}No changes in any repository.${RESET}\n"
    notify-send "✅ Eudaimonia Sync Complete" "All repositories already up-to-date" -u normal
fi
