#!/bin/bash

cd /tmp

redis=redis-2.6.5
redis_file=${redis}.tar.gz
redis_url=http://redis.googlecode.com/files/${redis_file}

wget $redis_url
mv $redis $redis_file
tar zxf $redis_file
cd $redis

make
make install
