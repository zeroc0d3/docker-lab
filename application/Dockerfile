FROM zeroc0d3lab/centos-application-lite:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Set Environment
#-----------------------------------------------------------------------------
ENV PATH_HOME=/home/docker \
    PATH_WORKSPACE=/home/docker/workspace \
    PATH_APPLICATION=/home/docker/workspace
		
USER root
#-----------------------------------------------------------------------------
# Install Application Dependency
#-----------------------------------------------------------------------------
RUN yum -y install \
      --setopt=tsflags=nodocs \
      --disableplugin=fastestmirror \
        gcc \
        gcc-c++ \
        kernel-devel \
        readline-dev \
        ncurses \
        ncurse-devel \
        lua-devel \ 
        lzo-devel \
        vim* 

RUN yum -y install ImageMagick ImageMagick-devel

#-----------------------------------------------------------------------------
# Clean Up All Cache
#-----------------------------------------------------------------------------
RUN yum clean all

#-----------------------------------------------------------------------------
# Set Configuration
#-----------------------------------------------------------------------------
COPY rootfs/ /

#-----------------------------------------------------------------------------
# Create Workspace Application Folder
#-----------------------------------------------------------------------------
RUN mkdir -p ${PATH_WORKSPACE}

#-----------------------------------------------------------------------------
# Fixing ownership for 'docker' user
#-----------------------------------------------------------------------------
RUN chown -R docker:docker ${PATH_HOME}

#-----------------------------------------------------------------------------
# Cleanup 'root', 'opt' & 'tmp' folder
#-----------------------------------------------------------------------------
RUN rm -f /root/*.tar.gz \
    && rm -f /root/*.zip \
    && rm -f /opt/*.tar.gz \
    && rm -f /opt/*.zip \
    && rm -f /tmp/*.tar.gz \
    && rm -f /tmp/*.zip 

#-----------------------------------------------------------------------------
# Set PORT Docker Container
#-----------------------------------------------------------------------------
EXPOSE 22

#-----------------------------------------------------------------------------
# Set Volume Docker Workspace
#-----------------------------------------------------------------------------
VOLUME [${PATH_WORKSPACE}]

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
ENTRYPOINT ["/init"]
CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]

#-----------------------------------------------------------------------------
# Check Docker Container
#-----------------------------------------------------------------------------
# HEALTHCHECK CMD [ $(curl -sI -w '%{http_code}' --out /dev/null http://localhost:8500/v1/agent/self) == "200" ] || exit 1
HEALTHCHECK CMD --interval=5m --timeout=3s /etc/cont-consul/check || exit 1