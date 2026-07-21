<div align="center">

# eudaimonia _(εὐδαιμονία)_
###### _noun_ · happiness; well-being.

![](https://raw.githubusercontent.com/akai-hana/assets/main/eudaimonia.png)

</div>

---

# About εὐδαιμονία
This repository contains my complete system-wide configuration. It spans through multiple repositories, including a general dotfiles repo as well as other repositories I've created to separate some components apart.

Some of the components on my system are distinct enough that I decided to dedicate them their own repository, instead of cramming them all under a single "dotfiles" repository. With this though, I lost the centralization benefit of a mono-repo.

To gain this back, I made this eudaimonia repo, which unifies all of the repositories into one meta-repository, bringing back this convenience while also keeping dedicated components separate.

In addition, I also provide some utilities to automate the configuration and syncing of all repositories inside, setting them as git modules. This way, these repositories are always automatically backed up, configured and up-to-date as my system's configuration changes through the time, with the help of a a simple cron job.

# Installation
```
git clone https://github.com/akai-hana/eudaimonia
cd eudaimonia
./pull-submodules.sh # This will iterate and pull through all the repos contained as sub-modules within this repository 
```
