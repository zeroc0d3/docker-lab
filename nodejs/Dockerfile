FROM dockerlab/base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV GIT_HOME=/home/docker

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ nodejs nodejs-npm && \
    rm -rf /var/cache/apk/*

ENV APP_PATH=${GIT_HOME}/workspace
RUN mkdir -p ${APP_PATH}

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 22
VOLUME ["/home"]