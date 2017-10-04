FROM dockerlab/base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV PGHOME=/var/lib/postgresql \
    PGDATA=/var/lib/postgresql/data

RUN apk update \
    && apk add --update postgresql postgresql-contrib \
    && mkdir -p ${PGHOME} ${PGDATA} \
    && chown -R postgres ${PGHOME} \
    && rm -rf /var/cache/apk/* \

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 5432
VOLUME ["/var/lib/postgresql"]
