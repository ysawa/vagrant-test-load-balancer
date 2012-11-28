#!/bin/bash

cd /tmp

magick=GraphicsMagick-1.3.17
magick_file=${magick}.tar.gz
magick_url='http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.17/GraphicsMagick-1.3.17.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fgraphicsmagick%2Ffiles%2F&ts=1354092210&use_mirror=jaist'

wget $magick_url
mv $magick* $magick_file
tar zxf $magick_file
cd $magick

./configure
make
make install
