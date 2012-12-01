#!/bin/bash

cd /tmp
git clone git://nagiosplug.git.sourceforge.net/gitroot/nagiosplug/nagiosplug
cd nagiosplug
./tools/setup
./configure
make
make install
