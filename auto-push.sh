#!/bin/sh
# pushes changes to all repos inside the dir
$EUDAIMONIA=~/eudaimonia/

cd $EUDAIMONIA
# Loop and push all sub-modules
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

# Push eudaimonia
cd $EUDAIMONIA
echo "Syncing $EUDAIMONIA"
git add .
git commit -m "automated sync"
git push
