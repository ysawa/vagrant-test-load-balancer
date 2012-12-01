#!/bin/bash

cd /tmp
nagios=nagios-3.4.1
nagios_file=${nagios}.tar.gz
nagios_url=http://prdownloads.sourceforge.net/sourceforge/nagios/${nagios_file}

wget $nagios_url
tar zxf $nagios_file
cd nagios

./configure
make all
make install install-init install-commandmode
make install-config
