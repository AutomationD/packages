#!/bin/bash
version=1.7.7.2

wget http://openresty.org/download/ngx_openresty-${version}.tar.gz
tar zxf ngx_openresty-${version}.tar.gz
cd ngx_openresty-${version}

./configure --with-luajit \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-client-body-temp-path=/var/lib/nginx/body \
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
--http-log-path=/var/log/nginx/access.log \
--http-proxy-temp-path=/var/lib/nginx/proxy \
--http-scgi-temp-path=/var/lib/nginx/scgi \
--http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
--lock-path=/var/lock/nginx.lock \
--pid-path=/run/nginx.pid \
--with-http_dav_module \
--with-http_flv_module \
--with-http_geoip_module \
--with-http_gzip_static_module \
--with-http_image_filter_module \
--with-http_realip_module \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_sub_module \
--with-http_xslt_module \
--with-ipv6 \
--with-sha1=/usr/include/openssl \
--with-md5=/usr/include/openssl \
--with-mail \
--with-mail_ssl_module \
--with-http_stub_status_module \
--with-http_secure_link_module \
--with-http_sub_module
# It will take ~15 minutes

make # Another ~15 minutes

INSTALL=/tmp/openresty
make install DESTDIR=$INSTALL
mkdir -p $INSTALL/var/lib/nginx

# fpm installation
apt-get -y install make ruby1.9.1 ruby1.9.1-dev \
git-core libpcre3-dev libxslt1-dev libgd2-xpm-dev \
libgeoip-dev unzip zip build-essential gem

gem install fpm

# Change dir back
cd ../
# Package building
fpm -s dir -t deb -n openresty -v ${version} --iteration 1 -C $INSTALL \
--description "openresty ${version}" \
-d libxslt1.1 \
-d libgd2-xpm \
-d libgeoip1 \
-d libpcre3 \
-d "nginx-common (>= 1.2.0)" \
--conflicts nginx-extras \
--conflicts nginx-full \
--conflicts nginx-light \
run usr var