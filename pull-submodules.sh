#!/bin/sh
# permission junk
git config --global --add safe.directory $HOME/eudaimonia
chown -R $USER:$USER $HOME/eudaimonia/.git

# pulls/updates all submodules and checks out main branch (master if fallback)
git submodule update --init --recursive
git submodule foreach 'git checkout main || git checkout master'
