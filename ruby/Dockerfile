FROM zeroc0d3lab/centos-base-workspace-lite:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Set Environment
#-----------------------------------------------------------------------------
ENV VIM_VERSION=8.0.1207 \
    LUA_VERSION=5.3.4 \
    LUAROCKS_VERSION=2.4.3 \
    RUBY_VERSION=2.4.2 \
    PATH_HOME=/home/docker \
    PATH_WORKSPACE=/home/docker/workspace

ENV RUBY_PACKAGE="rbenv"
    # ("rbenv" = using rbenv package manager, "rvm" = using rvm package manager)

USER root
#-----------------------------------------------------------------------------
# Find Fastest Repo & Update Repo
#-----------------------------------------------------------------------------
RUN yum makecache fast \
    && yum -y update

#-----------------------------------------------------------------------------
# Install Ruby Dependency (1)
#-----------------------------------------------------------------------------
RUN yum -y install \
           --setopt=tsflags=nodocs \
           --disableplugin=fastestmirror \
         git \
         git-core \
         zsh \
         gcc \
         gcc-c++ \
         autoconf \
         automake \
         make \
         libevent-devel \
         ncurses-devel \
         glibc-static \
         fontconfig \
         kernel-devel \
         readline-dev \
         lua-devel \ 
         lzo-devel \

#-----------------------------------------------------------------------------
# Install MySQL (MariaDB) Library
#-----------------------------------------------------------------------------
         mysql-devel \

#-----------------------------------------------------------------------------
# Install PostgreSQL Library
#-----------------------------------------------------------------------------
### PostgreSQL 9.2 (default)###
         postgresql-libs \
         postgresql-devel \

### PostgreSQL 9.6 ###
    && rpm -iUvh https://yum.postgresql.org/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm \
    && yum install -y postgresql96-libs postgresql96-server postgresql96-devel \

#-----------------------------------------------------------------------------
# Install Ruby Dependency (2)
#-----------------------------------------------------------------------------
RUN yum -y install \
           --setopt=tsflags=nodocs \
           --disableplugin=fastestmirror \
         zlib \
         zlib-devel \
         patch \
         readline \
         readline-devel \
         libyaml-devel \
         libffi-devel \
         openssl-devel \
         bzip2 \
         bison \
         libtool \
         sqlite-devel

#-----------------------------------------------------------------------------
# Clean Up All Cache
#-----------------------------------------------------------------------------
RUN yum clean all

#-----------------------------------------------------------------------------
# Prepare Install Ruby
# -) copy .zshrc to /root
# -) copy .bashrc to /root
#-----------------------------------------------------------------------------
RUN git clone https://github.com/zeroc0d3/ruby-installation /opt/ruby_installer 

COPY ./rootfs/root/.zshrc /root/.zshrc
COPY ./rootfs/root/.bashrc /root/.bashrc
RUN sudo /bin/sh /opt/ruby_installer/install_ruby.sh

#-----------------------------------------------------------------------------
# Install Ruby Packages (rbenv/rvm)
#-----------------------------------------------------------------------------
RUN sudo /bin/sh /opt/ruby_installer/gems.sh

# -----------------------------------------------------------------------------
# UTC Timezone & Networking
# -----------------------------------------------------------------------------
RUN ln -sf \
		/usr/share/zoneinfo/UTC \
		/etc/localtime \
	&& echo "NETWORKING=yes" > /etc/sysconfig/network

#-----------------------------------------------------------------------------
# Set Configuration
#-----------------------------------------------------------------------------
COPY rootfs/ /

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
# Change 'root' & 'docker' user Password
#-----------------------------------------------------------------------------
# RUN echo 'root:'${SSH_ROOT_PASSWORD} | chpasswd
RUN echo 'root:docker' | chpasswd \
    && echo 'docker:docker' | chpasswd

#-----------------------------------------------------------------------------
# Generate Public Key
#-----------------------------------------------------------------------------
# Create new public key
RUN /usr/bin/ssh-keygen -t rsa -b 4096 -C "zeroc0d3.team@gmail.com" -f $HOME/.ssh/id_rsa -q -N ""; sync

RUN mkdir -p $HOME/.ssh \
    && touch $HOME/.ssh/authorized_keys \
    && chmod 700 $HOME/.ssh \
    && chmod go-w $HOME $HOME/.ssh \
    && chmod 600 $HOME/.ssh/authorized_keys \
    && chown `whoami` $HOME/.ssh/authorized_keys \
    && cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys

# Create new pem file from public key
RUN /usr/bin/ssh-keygen -f $HOME/.ssh/id_rsa.pub -e -m pem > $HOME/.ssh/id_rsa.pem

# Create new public key for host
RUN /usr/bin/ssh-keygen -A

RUN mkdir -p /home/docker/.ssh \
    && touch /home/docker/.ssh/authorized_keys \
    && cat $HOME/.ssh/id_rsa.pub > /home/docker/.ssh/authorized_keys \
    && /usr/bin/ssh-keygen -f $HOME/.ssh/id_rsa.pub -e -m pem > /home/docker/.ssh/id_rsa.pem \
    && chmod 700 /home/docker/.ssh \
    && chmod 600 /home/docker/.ssh/authorized_keys \
    && chmod 600 /home/docker/.ssh/id_rsa*

#-----------------------------------------------------------------------------
# Create Workspace Application Folder
#-----------------------------------------------------------------------------
RUN mkdir -p ${PATH_WORKSPACE}

#-----------------------------------------------------------------------------
# Fixing ownership for 'docker' user
#-----------------------------------------------------------------------------
RUN chown -R docker:docker ${PATH_HOME}

#-----------------------------------------------------------------------------
# Set Volume Docker Workspace
#-----------------------------------------------------------------------------
VOLUME [${PATH_WORKSPACE}]

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
ENTRYPOINT ["/init"]
CMD []

## NOTE:
## *) Run vim then >> :PluginInstall
## *) Update plugin vim (vundle) >> :PluginUpdate
## *) Run in terminal >> vim +PluginInstall +q
##                       vim +PluginUpdate +q
