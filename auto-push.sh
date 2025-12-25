#!/bin/sh
# pushes changes to all repos inside the dir
DIR=~/eudaimonia/

cd $DIR
# Loop and push all sub-modules
for dir in */; do
    cd "$DIR" || continue
    
    if [ -d .git ] || [ -f .git ]; then
        echo "Syncing $DIR"
        git add .
        git commit -m "automated sync"
        git push
    fi
    
    cd ..
done

# Push eudaimonia
cd $DIR
echo "Syncing $DIR"
git add .
git commit -m "automated sync"
git push
