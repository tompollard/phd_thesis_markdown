FROM pandoc/ubuntu-latex

RUN tlmgr update --self \
    && tlmgr install truncate \
    && tlmgr install tocloft \
    && tlmgr install wallpaper \
    && tlmgr install morefloats \
    && tlmgr install sectsty \
    && tlmgr install siunitx \
    && tlmgr install threeparttable \
    && tlmgr install makecell \
    && tlmgr update l3packages \
    && tlmgr update l3kernel \
    && tlmgr update l3experimental

RUN apt-get update \
    && apt-get install -y python3 python3-pip pandoc-citeproc \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install \
    pandoc-fignos \
    pandoc-eqnos \
    pandoc-tablenos \
    pandoc-secnos \
    pandoc-shortcaption \
    fabric
