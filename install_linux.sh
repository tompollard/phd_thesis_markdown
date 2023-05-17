#!/usr/bin/env bash

set -e  # makes the script fail as soon as one command fails

sudo env PATH=$PATH tlmgr install truncate
sudo env PATH=$PATH tlmgr install tocloft
sudo env PATH=$PATH tlmgr install wallpaper
sudo env PATH=$PATH tlmgr install morefloats
sudo env PATH=$PATH tlmgr install sectsty
sudo env PATH=$PATH tlmgr install siunitx
sudo env PATH=$PATH tlmgr install threeparttable
sudo env PATH=$PATH tlmgr update l3packages
sudo env PATH=$PATH tlmgr update l3kernel
sudo env PATH=$PATH tlmgr update l3experimental
sudo env PATH=$PATH tlmgr update l3backend
sudo env PATH=$PATH tlmgr install mathspec
sudo env PATH=$PATH tlmgr install xltxtra
sudo env PATH=$PATH tlmgr install realscripts
sudo env PATH=$PATH tlmgr install eso-pic
sudo env PATH=$PATH tlmgr install ctable
sudo env PATH=$PATH tlmgr install listings
sudo env PATH=$PATH tlmgr install pdfpages
sudo env PATH=$PATH tlmgr install bbold
sudo env PATH=$PATH tlmgr install cleveref
sudo env PATH=$PATH tlmgr install fancyhdr
sudo env PATH=$PATH tlmgr install ulem
sudo env PATH=$PATH tlmgr install setspace
sudo env PATH=$PATH tlmgr install makecell
sudo env PATH=$PATH tlmgr install pdflscape
sudo env PATH=$PATH tlmgr install caption

#
# Would it be simpler to just update all packages? (takes ~10m)
# sudo tlmgr update --all
pip install pandoc-fignos pandoc-eqnos pandoc-tablenos pandoc-secnos pandoc-shortcaption
