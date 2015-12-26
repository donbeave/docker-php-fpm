FROM buildpack-deps:wheezy-curl

MAINTAINER Alexey Zhokhov <alexey@zhokhov.com>

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
	&& apt-get update \
	&& apt-get install -y php5 php5-fpm php5-gd php5-mysql php5-dev php5-cli php-pear php5-memcache make libcurl4-openssl-dev libsasl2-dev libpcre3-dev \
	&& pecl install mongodb \
	&& pecl install redis \
	&& apt-get remove -y php5-dev libcurl4-openssl-dev libsasl2-dev libpcre3-dev make \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ADD php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD pool.d/ /etc/php5/fpm/pool.d
ADD run.sh /run.sh

RUN chmod a+x /run.sh
RUN mkdir -p /etc/php5/cli; ln -s /etc/php5/fpm/php.ini /etc/php5/cli/php.ini

# forward logs to docker log collector
RUN ln -sf /dev/stdout /var/log/php5-fpm.log

EXPOSE 9000
CMD ["/run.sh"]
