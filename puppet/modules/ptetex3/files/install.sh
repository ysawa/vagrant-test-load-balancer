#!/bin/bash

ptetex3=ptetex3-20090504
ptetex3_file=${ptetex3}.tar.gz

cd /tmp
mkdir -p ptetex3; cd ptetex3
wget http://tutimura.ath.cx/~nob/tex/ptetex/ptetex3/${ptetex3_file}
wget http://www.ring.gr.jp/pub/text/CTAN/obsolete/systems/unix/teTeX/3.0/distrib/tetex-src-3.0.tar.gz
wget http://www.ring.gr.jp/pub/text/CTAN/obsolete/systems/unix/teTeX/3.0/distrib/tetex-texmf-3.0po.tar.gz

tar zxf $ptetex3_file
cd $ptetex3
cp /tmp/puppet_ptetex3_my_option ./my_option
make
