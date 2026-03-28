<div align="center">

# eudaimonia _(εὐδαιμονία)_
###### _noun_ · happiness; well-being.

![](https://raw.githubusercontent.com/akai-hana/assets/main/eudaimonia.png)

</div>

---

# Installation
```
git clone https://github.com/akai-hana/eudaimonia
cd eudaimonia
./pull-submodules.sh # This will iterate and pull through all the repos contained as sub-modules within this repository 
```

# About εὐδαιμονία
Eudaimonia is a synonym of happiness. I chose it to name this meta-repo, which contains my complete system-wide configuration, which spans through multiple repositories.

Some of the components on my system are distinct enough that they don't all fit under a single "dotfiles" repository, so that's why this meta-repository is useful.

Eudaimonia doesn't actually contain much itself. Instead it just collects multiple other repos in a single place, hence me calling it a "meta"-repo.

When I want to pull all of my system's components, this repository provides some utilities to automate the configuration and syncing of all repositories inside, setting them as "modules". This way, these repositories are always automatically configured and up-to-date as my system's configuration changes, through a simple cron job, or appending the script's execution on each xinit.
