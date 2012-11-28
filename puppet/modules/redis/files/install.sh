#!/bin/bash

cd /tmp

user=redis
redis=redis-2.6.5
redis_file=${redis}.tar.gz
redis_url=http://redis.googlecode.com/files/${redis_file}

if ! id -u $user > /dev/null 2>&1; then
  useradd -s /sbin/nologin $user
fi

wget $redis_url
mv $redis $redis_file
tar zxf $redis_file
cd $redis

make
make install
