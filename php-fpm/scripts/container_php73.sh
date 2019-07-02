#!/bin/bash
docker run -d --name php7.3-fpm-alpine -p 9000:9000 -v ~/php/www/html:/usr/local/nginx/html  -it php:7.3-fpm-alpine