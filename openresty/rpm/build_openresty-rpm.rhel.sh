#!/bin/bash
yum install -y readline-devel pcre-devel openssl-devel gcc gcc-c++ zlib-devel make unzip git gd-devel geoip-devel rpm-build
gem install fpm

##########
openresty_version=1.7.7.2
pagespeed_version=1.9.32.3

 
# wget http://openresty.org/download/ngx_openresty-${openresty_version}.tar.gz
# tar zxf ngx_openresty-${openresty_version}.tar.gz
# cd ngx_openresty-${openresty_version}


# wget https://github.com/pagespeed/ngx_pagespeed/archive/v${pagespeed_version}-beta.zip
# unzip v${pagespeed_version}-beta.zip
# cd ngx_pagespeed-${pagespeed_version}-beta

base=$PWD
git clone https://github.com/needcaffeine/ngx_openresty
cd ngx_openresty
build=$PWD

wget https://dl.google.com/dl/page-speed/psol/${pagespeed_version}.tar.gz -O $build/packages/ngx_pagespeed-release-1.9.32.3-beta/${pagespeed_version}.tar.gz
cd packages/ngx_pagespeed-release-1.9.32.3-beta/
tar zxf ${pagespeed_version}.tar.gz

cd $build

wget https://www.openssl.org/source/openssl-1.0.1i.tar.gz -O $build/packages/openssl-1.0.1i.tar.gz
cd $build/packages/
tar zxf openssl-1.0.1i.tar.gz
mv openssl-1.0.1i openssl

cd $build


./configure --with-luajit \
--with-pcre-jit \
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
--with-http_sub_module \
--add-module=$build/packages/ngx_pagespeed-release-${pagespeed_version}-beta \
--with-openssl=$build/packages/openssl

 
make
 
INSTALL=$base/openresty
make install DESTDIR=$INSTALL
mkdir -p $INSTALL/var/lib/nginx
mkdir -p $INSTALL/etc/init.d/
mkdir -p $INSTALL/etc/sysconfig/

cp $base/init.d-rhel $INSTALL/etc/init.d/nginx
cp $base/sysconfig-rhel $INSTALL/etc/sysconfig/nginx

chmod +rx $INSTALL/etc/init.d/nginx
# fpm installation
#yum -y install ruby1.9.1 ruby1.9.1-dev git-core libpcre3-dev libxslt1-dev libgd2-xpm-dev libgeoip-dev unzip zip build-essential gem
 

 
# Change dir back
cd $base
# Package building
rm -rf *.rpm
fpm -s dir -t rpm -n openresty -v ${openresty_version} --iteration 1 -C $INSTALL --before-install "before-install.sh" --after-remove "after-remove.sh"
# --before-remove "bash -c 'service nginx stop && userdel nginx'"
# fpm -s dir -t rpm -n openresty -v ${openresty_version} --iteration 1 -C $INSTALL \
# --description "openresty ${openresty_version}" \
# -d libxslt1.1 \
# -d libgd2-xpm \
# -d libgeoip1 \
# -d libpcre3 \
# -d "nginx-common (>= 1.2.0)" \
# --conflicts nginx-extras \
# --conflicts nginx-full \
# --conflicts nginx-light \
# run usr var