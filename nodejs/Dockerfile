FROM zeroc0d3lab/centos-base-consul-lite:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Set Environment
#-----------------------------------------------------------------------------
ENV GIT_HOME=/home/docker

USER root
#-----------------------------------------------------------------------------
# Find Fastest Repo & Update Repo
#-----------------------------------------------------------------------------
RUN yum makecache fast \
    && yum -y update

#-----------------------------------------------------------------------------
# Install Workspace Dependency
#-----------------------------------------------------------------------------
RUN yum -y install \
           --setopt=tsflags=nodocs \
           --disableplugin=fastestmirror \
         git \
         nano \
         zip \
         unzip \
         zsh \
         gcc \
         automake \
         make \
         libevent-devel \
         ncurses-devel \
         glibc-static \

#-----------------------------------------------------------------------------
# Install NodeJS Dependency
#-----------------------------------------------------------------------------
RUN yum -y install \
           --setopt=tsflags=nodocs \
           --disableplugin=fastestmirror \
         git-core \
         zlib \
         zlib-devel \
         gcc-c++ \
         patch \
         readline \
         readline-devel \
         libyaml-devel \
         libffi-devel \
         openssl-devel \
         make \
         bzip2 \
         bison \
         autoconf \
         automake \
         libtool \
         sqlite-devel

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
# Setup Locale UTF-8
#-----------------------------------------------------------------------------
RUN ["/usr/bin/localedef", "-i", "en_US", "-f", "UTF-8", "en_US.UTF-8"]

#-----------------------------------------------------------------------------
# Create Workspace Application Folder
#-----------------------------------------------------------------------------
RUN mkdir -p ${GIT_HOME}/workspace

#-----------------------------------------------------------------------------
# Set PORT Docker Container
#-----------------------------------------------------------------------------
EXPOSE 22

#-----------------------------------------------------------------------------
# Set Volume Application
#-----------------------------------------------------------------------------
VOLUME ["/home", "/root"]

#-----------------------------------------------------------------------------
# Setup TrueColors (Terminal)
#-----------------------------------------------------------------------------
COPY ./rootfs/root/colors/24-bit-color.sh /root/colors/24-bit-color.sh
RUN chmod +x /root/colors/24-bit-color.sh \
    ./root/colors/24-bit-color.sh

#-----------------------------------------------------------------------------
# Finalize (reconfigure)
#-----------------------------------------------------------------------------
COPY rootfs/ /

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
ENTRYPOINT ["/init"]
CMD []
