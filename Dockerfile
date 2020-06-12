FROM aergus/latex

RUN apt-get update --assume-yes && \
apt-get install --assume-yes make \
python3-dev \
python3-pip
RUN tlmgr init-usertree
RUN tlmgr install truncate \
tocloft \
wallpaper \
morefloats \
sectsty \
siunitx \
threeparttable
RUN tlmgr update l3packages \
l3kernel \
l3experimental
RUN python3 -m pip install pandoc-fignos pandoc-eqnos pandoc-tablenos \
pandoc-secnos pandoc-shortcaption

COPY . .
WORKDIR /data
ENTRYPOINT ["make"]
