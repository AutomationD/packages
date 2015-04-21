#!/bin/bash
u="nginx"
id -u $u &>/dev/null || useradd $u -d /var/lib/nginx -s /sbin/nologin