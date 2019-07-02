#
# Dockerfile for building MySQL images
# 
# https://github.com/addcn/docker-lnmp.git
#

FROM mysql:5.7
MAINTAINER majikang <majikang0621@gmail.com>

# COPY startup /etc/mysql/startup
COPY config/my.cnf /etc/mysql/conf.d/my.cnf

# RUN chown -R mysql:root /var/lib/mysql/

# RUN sed -i 's/MYSQL_DATABASE/'$MYSQL_DATABASE'/g' /etc/mysql/startup && \
#     sed -i 's/MYSQL_USER/'$MYSQL_USER'/g' /etc/mysql/startup && \
#     sed -i 's/MYSQL_PASSWORD/'$MYSQL_PASSWORD'/g' /etc/mysql/startup

CMD ["mysqld"]
