# PHP-FPM (Docker)

[![Build Status](https://circleci.com/gh/donbeave/docker-php-fpm.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/donbeave/docker-php-fpm)
[![Analytics](https://ga-beacon.appspot.com/UA-71075299-1/docker-php-fpm/main-page)](https://github.com/igrigorik/ga-beacon)

Lightweight container contains PHP5-FPM with some basic plugins (based on minimalist Debian wheezy image)

Plugins list:
```
gd
mysql
memcache
mongodb
redis
```

### Docker image

https://hub.docker.com/r/donbeave/php-fpm

#### How to use?

In your `Dockerfile` use the following:
```
FROM donbeave/php-fpm:latest

...
```

Copyright and license
---------------------

Copyright 2015 Alexey Zhokhov under the [Apache License, Version 2.0](LICENSE). Supported by [AZ][zhokhov].

[zhokhov]: http://www.zhokhov.com
