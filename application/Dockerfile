FROM dockerlab/base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV GIT_HOME=/home/docker

RUN mkdir -p ${GIT_HOME} && \
    addgroup -S docker && \
    adduser -S -D -g "" -G docker -s /usr/bin/git-shell -h ${GIT_HOME} docker && \
    chown -R docker:docker ${GIT_HOME} && \
    mkdir -p ${GIT_HOME}/git-shell-commands && \
    chmod 755 ${GIT_HOME}/git-shell-commands

RUN apk add --update build-base docker git openssh openssh-client && \
    rm -rf /var/cache/apk/*

ENV APP_PATH=${GIT_HOME}/workspace
RUN mkdir -p ${APP_PATH}

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 22
VOLUME ["/home"]
