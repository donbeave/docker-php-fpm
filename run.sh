#!/bin/bash

if [ -n "$PHP_TIMEZONE" ]; then
    sed -i "s/;date.timezone =/date.timezone = $PHP_TIMEZONE/" /etc/php5/fpm/php.ini
fi

php5-fpm --nodaemonize
