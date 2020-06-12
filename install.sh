#!/usr/bin/env bash

sudo apt-get install pandoc-citeproc &&
sudo tlmgr install truncate &&
sudo tlmgr install tocloft &&
sudo tlmgr install wallpaper &&
sudo tlmgr install morefloats &&
sudo tlmgr install sectsty &&
sudo tlmgr install siunitx &&
sudo tlmgr install threeparttable &&
sudo tlmgr update l3packages &&
sudo tlmgr update l3kernel &&
sudo tlmgr update l3experimental &&
pip3 install pandoc-fignos pandoc-eqnos pandoc-tablenos \
            pandoc-secnos pandoc-shortcaption
