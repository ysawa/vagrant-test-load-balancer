#!/bin/bash

cd /tmp
nagois=nagios-3.4.1
nagois_file=${nagois}.tar.gz
nagois_url=http://prdownloads.sourceforge.net/sourceforge/nagios/${nagois_file}

wget $nagois_url
tar zxf $nagois_file
cd nagois

./configure
make all
make install
