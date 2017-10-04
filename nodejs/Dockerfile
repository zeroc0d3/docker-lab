FROM dockerlab/base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV GIT_HOME=/home/docker

RUN apk update \
    && apk add --update build-base docker bash git openssh-client

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ nodejs nodejs-npm \
    && mkdir -p ${GIT_HOME}/workspace \
    && rm -rf /var/cache/apk/* \

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 22
VOLUME ["/home"]