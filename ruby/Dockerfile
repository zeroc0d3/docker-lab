FROM dockerlab/base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV GIT_HOME=/home/docker

RUN apk add --update ruby ruby-irb ruby-rdoc && \
    rm -rf /var/cache/apk/*

ENV APP_PATH=${GIT_HOME}/workspace
RUN mkdir -p ${APP_PATH}

ENTRYPOINT ["/init"]
CMD []

EXPOSE 22
VOLUME ["/home"]