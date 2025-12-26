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
notify-send "🔄 Eudaimonia Sync" "<b>Starting sync</b> of all submodules..." -u normal -h string:body-markup:true

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
                while IFS= read -r file; do
                    CHANGES_SUMMARY="${CHANGES_SUMMARY}  - ${file}\n"
                done <<EOF
$CHANGED_FILES
EOF
                
                if git push 2>&1 | grep -q "Everything up-to-date"; then
                    notify-send "📦 $DIR" "Committed but already <b>up-to-date</b>" -u low -t 3000 -h string:body-markup:true
                else
                    notify-send "✨ $DIR" "<big><b>Changes pushed</b> successfully</big>" -u low -t 3000 -h string:body-markup:true
                fi
            fi
        else
            # No changes to commit
            notify-send "✓ $DIR" "<i>Nothing to sync</i>" -u low -t 3000 -h string:body-markup:true
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
        while IFS= read -r file; do
            CHANGES_SUMMARY="${CHANGES_SUMMARY}  - ${file}\n"
        done <<EOF
$CHANGED_FILES
EOF
    fi
    
    if git push 2>&1 | grep -q "Everything up-to-date"; then
        notify-send "📦 eudaimonia" "Committed but already <b>up-to-date</b>" -u low -t 3000 -h string:body-markup:true
    else
        notify-send "✨ eudaimonia" "<big><b>Meta-repository changes pushed</b></big>" -u low -t 3000 -h string:body-markup:true
    fi
else
    # No changes to commit
    notify-send "✓ eudaimonia" "<i>Nothing to sync</i>" -u low -t 3000 -h string:body-markup:true
fi

printf "\n${GREEN}DONE!${RESET}\n"

# Display summary of changes
if [ -n "$REPOS_WITH_CHANGES" ]; then
    printf "\n${CYAN}${BOLD}==> SUMMARY OF CHANGES:${RESET}\n"
    printf "%b\n" "$CHANGES_SUMMARY"
    
    # Send summary notification
    REPO_COUNT=$(echo "$REPOS_WITH_CHANGES" | wc -w)
    notify-send "✅ Eudaimonia Sync Complete" "<big><b>$REPO_COUNT repo(s) updated</b></big>\n$REPOS_WITH_CHANGES" -u normal -t 8000 -h string:body-markup:true
else
    printf "\n${YELLOW}No changes in any repository.${RESET}\n"
    notify-send "✅ Eudaimonia Sync Complete" "All repositories already <b>up-to-date</b>" -u normal -h string:body-markup:true
fi
