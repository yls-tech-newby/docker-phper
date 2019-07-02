FROM php:7.3-fpm-alpine

MAINTAINER majikang <majikang0621@gmail.com>


#####################################
# ENV BASE_DEPS:almost all builds depend on this
#####################################

ARG TZ=Asia/Shanghai
ARG INSTALL_XDEBUG=false
ARG INSTALL_PHPREDIS=false
ARG INSTALL_MONGO=false
ARG INSTALL_MEMCACHED=false
ARG INSTALL_PHPREDIS=false
ARG INSTALL_OPCACHE=false
ARG PUID=1000
ARG PGID=1000
ARG USER=work
ARG GROUP=work

ENV BASE_DEPS \
    autoconf 
    # dpkg-dev dpkg \
    # g++ \
    # make \
    # gcc \
    # file \
    # libc-dev \
    # pkgconf \
    # re2c 

ENV TZ ${TZ}

COPY ./php.ini /usr/local/etc/php
COPY ./www.conf /usr/local/etc/php-fpm.d/
COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini
#####################################
# VIRTUAL PKGS:virtual pkgs build
#####################################

RUN set -xe; \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
    apk add --no-cache --virtual .build-deps \
    $BASE_DEPS \
    tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    \
    && addgroup -g $PGID -S $USER \
    && adduser -u $PUID -D -S -G $USER $GROUP; \
    \
    # && docker-php-ext-configure gd \
    #     --with-gd \
    #     --with-freetype-dir=/usr/include/ \
    #     --with-png-dir=/usr/include/ \
    #     --with-jpeg-dir=/usr/include/ \
    # && docker-php-ext-install gd; \
    \
    if [ ${INSTALL_OPCACHE} = true ]; then \
        docker-php-ext-install opcache && \
        docker-php-ext-enable opcache \
    ;fi; \
    \
    if [ ${INSTALL_XDEBUG} = true ]; then \
        pecl install xdebug && docker-php-ext-enable xdebug \
    ;fi; \
    \
    if [ ${INSTALL_PHPREDIS} = true ]; then \
        pecl install -o -f redis \
        &&  docker-php-ext-enable redis \
    ;fi; \
    \
    if [ ${INSTALL_MONGO} = true ]; then \
        pecl install mongodb \
        && docker-php-ext-enable mongodb \
    ;fi; \
    \
    apk del --no-network .build-deps \
    && docker-php-source delete \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/cache/*




# www-data:www-data /var/www/html
# PHP_INI_DIR /usr/local/etc/php
# config_dir /usr/local/etc/php/conf.d
# root /var/www/html

#####################################
# Finally:
##################################### 

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000
