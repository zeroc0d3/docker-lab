FROM zeroc0d3lab/centos-base-workspace-lite:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Set Environment
#-----------------------------------------------------------------------------
ENV PATH_HOME=/home/docker \
    PATH_WORKSPACE=/home/docker/workspace

#-----------------------------------------------------------------------------
# Install NodeJS
#-----------------------------------------------------------------------------
# RUN yum -y install nodejs npm --enablerepo=epel \
RUN yum -y install https://kojipkgs.fedoraproject.org//packages/http-parser/2.7.1/3.el7/x86_64/http-parser-2.7.1-3.el7.x86_64.rpm nodejs \

#-----------------------------------------------------------------------------
# Clean Up All Cache
#-----------------------------------------------------------------------------
    && yum clean all

#-----------------------------------------------------------------------------
# Install Javascipt Unit Test
#-----------------------------------------------------------------------------
RUN /usr/bin/npm install chai \
    && /usr/bin/npm install tv4 \
    && /usr/bin/npm install newman \

#-----------------------------------------------------------------------------
# Install Javascipt Packages Manager
#-----------------------------------------------------------------------------
    && /usr/bin/npm install --global yarn \
    && /usr/bin/npm install --global bower \
    && /usr/bin/npm install --global grunt \
    && /usr/bin/npm install --global gulp \
    && /usr/bin/npm install --global yo

#-----------------------------------------------------------------------------
# Upgrade Javascipt Packages Manager
#-----------------------------------------------------------------------------
RUN /usr/bin/npm upgrade --global chai \
    && /usr/bin/npm upgrade --global tv4 \
    && /usr/bin/npm upgrade --global newman \
    && /usr/bin/npm upgrade --global yarn \
    && /usr/bin/npm upgrade --global bower \
    && /usr/bin/npm upgrade --global grunt \
    && /usr/bin/npm upgrade --global gulp \
    && /usr/bin/npm upgrade --global yo

#-----------------------------------------------------------------------------
# Move 'node_modules' To 'root' Folder
#-----------------------------------------------------------------------------
RUN mv /node_modules $HOME/node_modules

#-----------------------------------------------------------------------------
# Set Configuration
#-----------------------------------------------------------------------------
COPY rootfs/ /

#-----------------------------------------------------------------------------
# Cleanup 'root' folder
#-----------------------------------------------------------------------------
RUN rm -f /root/*.tar.gz \
    && rm -f /root/*.zip \
    && rm -f /opt/*.tar.gz \
    && rm -f /opt/*.zip

#-----------------------------------------------------------------------------
# Create Workspace Application Folder
#-----------------------------------------------------------------------------
RUN mkdir -p ${PATH_WORKSPACE} \
    mkdir -p /var/run/s6

#-----------------------------------------------------------------------------
# Fixing ownership for 'docker' user
#-----------------------------------------------------------------------------
RUN chown -R docker:docker ${PATH_HOME}

#-----------------------------------------------------------------------------
# Set PORT Docker Container
#-----------------------------------------------------------------------------
EXPOSE 22

#-----------------------------------------------------------------------------
# Set Volume Application
#-----------------------------------------------------------------------------
VOLUME [${PATH_WORKSPACE}]

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
ENTRYPOINT ["/init"]
CMD []
