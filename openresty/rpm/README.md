# Openresty
OpenResty (aka. ngx_openresty) is a full-fledged web application server by bundling the standard Nginx core, lots of 3rd-party Nginx modules, as well as most of their external dependencies.

By taking advantage of various well-designed Nginx modules, OpenResty effectively turns the nginx server into a powerful web app server, in which the web developers can use the Lua programming language to script various existing nginx C modules and Lua modules and construct extremely high-performance web applications that are capable to handle 10K+ connections.

OpenResty aims to run your server-side web app completely in the Nginx server, leveraging Nginx's event model to do non-blocking I/O not only with the HTTP clients, but also with remote backends like MySQL, PostgreSQL, Memcached, and Redis.

OpenResty is not an Nginx fork. It is just a software bundle. Most of the patches applied to the Nginx core in OpenResty have already been submitted to the official Nginx team and most of the patches submitted have also been accepted. We are trying hard not to fork Nginx and always to use the latest best Nginx core from the official Nginx team.


## Release info
This pacakge is based on https://github.com/needcaffeine/ngx_openresty
This package was built using the following parameters:
```bash
./configure  --prefix=/etc \
--with-luajit \
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
```