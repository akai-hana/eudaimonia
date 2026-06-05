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
Eudaimonia (synonym of happiness) is this repository, which contains my complete system-wide configuration, spanning through multiple repositories.

Some of the components on my system are distinct enough that they just don't fit under a single "dotfiles" repository, and instead are stored on their own repositories. The combination of all of these are what make my entire system.

In here I also provide some utilities to automate the configuration and syncing of all repositories inside, setting them as git modules. This way, these repositories are always automatically configured and up-to-date as my system's configuration changes, through a simple cron job or however else, to achieve some sort of scuffed CI or backup of my system's configurations.
