FROM nginx:alpine

MAINTAINER majikang <majikang0621@gmail.com>

ARG TZ=Asia/Shanghai
ARG PUID=1000
ARG PGID=1000
ARG USER=work
ARG GROUP=work

ADD nginx.conf /etc/nginx/

RUN set -xe; \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
    apk add --no-cache --virtual .build-deps \
    tzdata \
	\
	&& cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    \
    && addgroup -g $PGID -S $USER \
    && adduser -u $PUID -D -S -G $USER $GROUP \
	\
	&& rm /etc/nginx/conf.d/default.conf \
	&& apk del --no-network .build-deps

CMD ["nginx-debug"]
EXPOSE 80 443
