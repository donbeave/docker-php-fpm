FROM php:5.6.16-fpm

MAINTAINER Alexey Zhokhov <alexey@zhokhov.com>

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Install other needed extensions
RUN set -x \
    && apt-get update \
    && apt-get install -y libfreetype6 libjpeg62-turbo libmcrypt4 libpng12-0 \
       sendmail --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN buildDeps="libfreetype6-dev libjpeg-dev libldap2-dev libmcrypt-dev \
               libpng12-dev zlib1g-dev libcurl4-openssl-dev libsasl2-dev \
               libpcre3-dev libjpeg62-turbo-dev libssl-dev pkg-config"; \
    set -x \
    && apt-get update \
    && apt-get install -y $buildDeps --no-install-recommends \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \
                                   --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysql --with-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-install gd mysql mysqli pdo_mysql iconv mbstring mcrypt zip \
    && pecl install redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && pecl install mongodb \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini \
    && rm -rf /tmp/mongodb.tar.gz /tmp/mongodb \
    && apt-get purge -y ${buildDeps} \
    && rm -rf /var/lib/apt/lists/*

ADD php.ini /usr/local/etc/php/php.ini
ADD run.sh /run.sh

RUN chmod a+x /run.sh

VOLUME ["/data"]

EXPOSE 9000
CMD ["/run.sh"]
