FROM alpine:latest

MAINTAINER majikang <majikang0621@gmail.com>

ARG TZ=UTC
ARG PUID=1000
ARG PGID=1000
ARG INSTALL_COMPOSER=false
ARG INSTALL_WORKSPACE_SSH=false
ARG USER=work
ARG GROUP=work
ARG USER_PWD=work


RUN set -xe; \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
	apk add --no-cache \
	php7 php7-openssl \
	php7-json php7-phar php7-mbstring \
	openssh bash \
	&& /usr/bin/ssh-keygen -A \
	&& ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key \
	&& rm -rf /var/cache/apk/*

COPY sshd_config /etc/ssh/sshd_config

RUN set -xe; \
	\
	apk add --no-cache --virtual .build-deps \
    tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    \
    && addgroup -g $PGID -S $GROUP \
    && adduser -u $PUID -s /bin/sh -G $USER $GROUP \
	&& chown -R $USER:$GROUP /home/$USER; \
	\
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone; \
	\
	if [ ${INSTALL_COMPOSER} = true ]; then \
	    php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
	    && php composer-setup.php \
	    && mv composer.phar /usr/local/bin/composer \
	    && rm -rf composer-setup.php \
	    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
	    && composer selfupdate && composer --version \
	;fi; \
	\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& apk del --no-network .build-deps; 

COPY ./aliases.sh /root/aliases.sh
COPY ./composer.json /root/.composer/composer.json
COPY ./composer.json /home/$USER/.composer/composer.json

RUN echo work:work | chpasswd && \
 	composer global install && \
	echo "" >> ~/.bashrc && \
	echo 'export PATH="~/.composer/vendor/bin:$PATH"' >> ~/.bashrc && \
    echo "# Load Custom Aliases" >> ~/.bashrc && \
    echo "source ~/aliases.sh" >> ~/.bashrc && \
    echo "" >> ~/.bashrc 

# USER $USER
# Set default work directory
WORKDIR /var/www

CMD ["/usr/sbin/sshd","-D"]

