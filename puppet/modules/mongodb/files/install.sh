#!/bin/bash

cd /tmp
mongodb="mongodb-linux-x86_64-2.2.1"
mongodb_file="${mongodb}.tgz"
mongodb_url="http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.2.1.tgz"
user="mongo"

if [ ! -f $mongodb_file ]
then
  wget $mongodb_url $mongodb_file
fi
tar zxf $mongodb_file
cd $mongodb

if ! id -u $user > /dev/null 2>&1; then
  useradd -s /sbin/nologin $user
fi

cp bin/* /usr/local/bin
