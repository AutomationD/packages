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
 
INSTALL=/tmp/openresty
make install DESTDIR=$INSTALL
mkdir -p $INSTALL/var/lib/nginx
mkdir -p $INSTALL/etc/init.d/

cat <<'EOF' > $INSTALL/etc/init.d/nginx
#!/bin/sh
#
# nginx - this script starts and stops the nginx daemon
#
# chkconfig:   - 85 15 
# description:  Nginx is an HTTP(S) server, HTTP(S) reverse \
#               proxy and IMAP/POP3 proxy server
# processname: nginx
# config:      /etc/nginx/nginx.conf
# config:      /etc/sysconfig/nginx
# pidfile:     /var/run/nginx.pid
 
# Source function library.
. /etc/rc.d/init.d/functions
. /etc/init.d/functions
 
# Source networking configuration.
. /etc/sysconfig/network
 
# Check that networking is up.
[ "$NETWORKING" = "no" ] && exit 0
 
nginx="/usr/sbin/nginx"
prog=$(buildname $nginx)
 
NGINX_CONF_FILE="/etc/nginx/nginx.conf"
 
[ -f /etc/sysconfig/nginx ] && . /etc/sysconfig/nginx
 
lockfile=/var/lock/subsys/nginx
 
make_dirs() {
   # make required directories
   user=`$nginx -V 2>&1 | grep "configure arguments:" | sed 's/[^*]*--user=\([^ ]*\).*/\1/g' -`
   if [ -z "`grep $user /etc/passwd`" ]; then
       useradd -M -s /bin/nologin $user
   fi
   options=`$nginx -V 2>&1 | grep 'configure arguments:'`
   for opt in $options; do
       if [ `echo $opt | grep '.*-temp-path'` ]; then
           value=`echo $opt | cut -d "=" -f 2`
           if [ ! -d "$value" ]; then
               # echo "creating" $value
               mkdir -p $value && chown -R $user $value
           fi
       fi
   done
}
 
start() {
    [ -x $nginx ] || exit 5
    [ -f $NGINX_CONF_FILE ] || exit 6
    make_dirs
    echo -n $"Starting $prog: "
    daemon $nginx -c $NGINX_CONF_FILE
    retval=$?
    echo
    [ $retval -eq 0 ] && touch $lockfile
    return $retval
}
 
stop() {
    echo -n $"Stopping $prog: "
    killproc $prog -QUIT
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f $lockfile
    return $retval
}
 
restart() {
    configtest || return $?
    stop
    sleep 1
    start
}
 
reload() {
    configtest || return $?
    echo -n $"Reloading $prog: "
    killproc $nginx -HUP
    RETVAL=$?
    echo
}
 
force_reload() {
    restart
}
 
configtest() {
  $nginx -t -c $NGINX_CONF_FILE
}
 
rh_status() {
    status $prog
}
 
rh_status_q() {
    rh_status >/dev/null 2>&1
}
 
case "$1" in
    start)
        rh_status_q && exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart|configtest)
        $1
        ;;
    reload)
        rh_status_q || exit 7
        $1
        ;;
    force-reload)
        force_reload
        ;;
    status)
        rh_status
        ;;
    condrestart|try-restart)
        rh_status_q || exit 0
            ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}"
        exit 2
esac
EOF

chmod +rx $INSTALL/etc/init.d/nginx
# fpm installation
#yum -y install ruby1.9.1 ruby1.9.1-dev git-core libpcre3-dev libxslt1-dev libgd2-xpm-dev libgeoip-dev unzip zip build-essential gem
 

 
# Change dir back
cd $base
# Package building
rm -rf *.rpm
fpm -s dir -t rpm -n openresty -v ${openresty_version} --iteration 1 -C $INSTALL
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