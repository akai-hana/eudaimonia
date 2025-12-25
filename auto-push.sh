#!/bin/sh
# pushes changes to all repos inside the dir
DIR=~/eudaimonia/

cd $DIR
for dir in */; do
    cd "$dir" || continue
    
    if [ -d .git ] || [ -f .git ]; then
        echo "Syncing $dir"
        git add .
        git commit -m "automated sync"
        git push
    fi
    
    cd ..
done
