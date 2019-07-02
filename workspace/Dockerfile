#
# Dockerfile for building PHP7 images
# https://github.com/majikang/docker-lnmp.git
#

FROM alpine:latest

MAINTAINER majikang <majikang0621@gmail.com>

ARG TZ=UTC
ARG PUID=1000
ARG PGID=1000
ARG INSTALL_COMPOSER=false
ARG INSTALL_WORKSPACE_SSH=false
ARG USER=work
ARG GROUP=work

USER root

COPY id_rsa /tmp/id_rsa
COPY id_rsa.pub /tmp/id_rsa.pub

RUN set -xe; \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
	apk add --no-cache \
	php7 php7-openssl

RUN set -xe; \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
	\
	apk add --no-cache --virtual .build-deps \
    tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    \
    && addgroup -g $PGID -S $USER \
    && adduser -u $PUID -D -S -G $USER $GROUP \
	&& chown -R $USER:$GROUP /home/$USER; \
	\
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone; \
	\
	if [ ${INSTALL_WORKSPACE_SSH} = true ]; then \
	    rm -f /etc/service/sshd/down && \
	    cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys \
	        && cat /tmp/id_rsa.pub >> /root/.ssh/id_rsa.pub \
	        && cat /tmp/id_rsa >> /root/.ssh/id_rsa \
	        && rm -f /tmp/id_rsa* \
	        && chmod 644 /root/.ssh/authorized_keys /root/.ssh/id_rsa.pub \
	    && chmod 400 /root/.ssh/id_rsa \
	;fi; \
	\
	if [ ${INSTALL_COMPOSER} = true ]; then \
	    php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
	    && php composer-setup.php \
	    && mv composer.phar /usr/local/bin/composer \
	    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
	    && composer selfupdate && composer --version \
	;fi; \
	\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& apk del --no-network .build-deps; 


COPY ./aliases.sh /home/$USER/aliases.sh

RUN echo "" >> ~/.bashrc && \
    echo "# Load Custom Aliases" >> ~/.bashrc && \
    echo "source /home/laradock/aliases.sh" >> ~/.bashrc && \
    echo "" >> ~/.bashrc 


USER $USER
RUN echo "" >> ~/.bashrc && \
    echo "# Load Custom Aliases" >> ~/.bashrc && \
    echo "source /home/laradock/aliases.sh" >> ~/.bashrc && \
    echo "" >> ~/.bashrc

# Set default work directory
WORKDIR /var/www
