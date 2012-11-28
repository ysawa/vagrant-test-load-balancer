#!/bin/bash

cd /tmp
nginx="nginx-1.3.8"
nginx_file="${nginx}.tar.gz"
nginx_url="http://nginx.org/download/${nginx_file}"
user="nginx"

if [ ! -f $nginx_file ]
then
  wget $nginx_url $nginx_file
fi
tar zxf $nginx_file
cd $nginx

if ! id -u $user > /dev/null 2>&1; then
  useradd -s /sbin/nologin $user
fi

./configure \
  --conf-path=/etc/nginx/nginx.conf \
  --error-log-path=/var/log/nginx/error.log \
  --pid-path=/var/run/nginx/nginx.pid  \
  --lock-path=/var/lock/nginx/nginx.lock \
  --user=nginx \
  --group=nginx \
  --with-http_stub_status_module \
  --with-http_ssl_module \
  --with-http_gzip_static_module \
  --with-http_realip_module \
  --http-log-path=/var/log/nginx/access.log \
  --http-client-body-temp-path=/var/tmp/nginx/client/ \
  --http-proxy-temp-path=/var/tmp/nginx/proxy/ \
  --http-fastcgi-temp-path=/var/tmp/nginx/fcgi/
make
make install
