#!/bin/bash

if [ -n "$PHP_TIMEZONE" ]; then
    echo "[Date]" >> /usr/local/etc/php/php.ini
    echo "date.timezone = '$PHP_TIMEZONE'" >> /usr/local/etc/php/php.ini
fi

php-fpm
