#!/usr/bin/env bash

set -e  # makes the script fail as soon as one command fails

sudo tlmgr install truncate
sudo tlmgr install tocloft
sudo tlmgr install wallpaper
sudo tlmgr install morefloats
sudo tlmgr install sectsty
sudo tlmgr install siunitx
sudo tlmgr install threeparttable
sudo tlmgr update l3packages
sudo tlmgr update l3kernel
sudo tlmgr update l3experimental
sudo tlmgr update l3backend
# Would it be simpler to just update all packages? (takes ~10m)
# sudo tlmgr update --all
pip install pandoc-fignos pandoc-eqnos pandoc-tablenos pandoc-secnos pandoc-shortcaption
