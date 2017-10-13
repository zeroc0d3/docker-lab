FROM bhuisgen/alpine-base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV PGHOME=/var/lib/postgresql \
    PGDATA=/var/lib/postgresql/data

ENV POSTGRESQL_DATABASE=mydb \
    POSTGRESQL_USERNAME=docker \
    POSTGRESQL_PASSWORD=password \
    POSTGRESQL_ADDRESS=172.16.0.0/12

# ENV POSTGRESQL_CONFIGSCRIPT=/root/postgresql/config.sh 

RUN apk add --update postgresql postgresql-contrib && \
    mkdir -p ${PGHOME} ${PGDATA} && \
    chown -R postgres ${PGHOME} && \
    rm -rf /var/cache/apk/*

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 5432
VOLUME ["/var/lib/postgresql"]
