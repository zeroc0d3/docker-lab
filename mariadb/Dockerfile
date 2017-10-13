FROM bhuisgen/alpine-base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV MARIADB_PROFILE=my-small \
    MARIADB_ROOTPASSWORD=mariadb \
    MARIADB_ROOTHOSTMASK=172.30.0.% \
    MARIADB_DATABASE=mydb \
    MARIADB_USERNAME=docker \
    MARIADB_PASSWORD=password \
    MARIADB_HOSTMASK=172.%.%.%

# ENV MARIADB_CONFIGSCRIPT=/root/mariadb/config.sh 

RUN apk add --update mariadb mariadb-common mariadb-client && \
    rm -rf /var/cache/apk/*

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 3306
VOLUME ["/var/lib/mysql"]
