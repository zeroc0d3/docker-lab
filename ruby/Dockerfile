FROM zeroc0d3lab/centos-base-consul-lite:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Set Environment
#-----------------------------------------------------------------------------
ENV RUBY_VERSION=2.4.2
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
    && yum install -y postgresql96-libs postgresql96-server postgresql96-devel

#-----------------------------------------------------------------------------
# Install Ruby Dependency
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
         sqlite-devel \

#-----------------------------------------------------------------------------
# Clean Up All Cache
#-----------------------------------------------------------------------------
    && yum clean all

#-----------------------------------------------------------------------------
# Setup Locale UTF-8
#-----------------------------------------------------------------------------
RUN ["/usr/bin/localedef", "-i", "en_US", "-f", "UTF-8", "en_US.UTF-8"]

#-----------------------------------------------------------------------------
# Prepare Install Ruby
# -) copy .zshrc to /root
# -) copy .bashrc to /root
#-----------------------------------------------------------------------------
COPY ./rootfs/root/.zshrc /root/.zshrc
COPY ./rootfs/root/.bashrc /root/.bashrc

#-----------------------------------------------------------------------------
# Install Ruby with rbenv (default)
#-----------------------------------------------------------------------------
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv \
    && git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build \
    && ./root/.rbenv/bin/rbenv install ${RUBY_VERSION} \
    && ./root/.rbenv/bin/rbenv global ${RUBY_VERSION} \
    && ./root/.rbenv/bin/rbenv rehash \
    && ./root/.rbenv/shims/ruby -v

#-----------------------------------------------------------------------------
# Install Ruby with rvm (alternatives)
#-----------------------------------------------------------------------------
# RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
#     && curl -sSL https://get.rvm.io | bash -s stable \
#     && ./root/.rvm/scripts/rvm install ${RUBY_VERSION} \
#     && ./root/.rvm/scripts/rvm use ${RUBY_VERSION} --default
#     && ./usr/bin/ruby -v

#-----------------------------------------------------------------------------
# Install Ruby Packages (rbenv)
#-----------------------------------------------------------------------------
RUN ./root/.rbenv/shims/gem install bundler \
    && ./root/.rbenv/shims/gem install rails \
    && ./root/.rbenv/shims/gem install rspec \
    && ./root/.rbenv/shims/gem install serverspec \
    && ./root/.rbenv/shims/gem install docker-api \
    && ./root/.rbenv/shims/gem install sqlite3 \
    && ./root/.rbenv/shims/gem install mongoid \
    && ./root/.rbenv/shims/gem install sequel \
    && ./root/.rbenv/shims/gem install pg \
    && ./root/.rbenv/shims/gem install mysql2 \
    && ./root/.rbenv/shims/gem install sequel_pg \
    && ./root/.rbenv/shims/gem install apktools \
    && ./root/.rbenv/shims/gem install rubocop

#-----------------------------------------------------------------------------
# Install Ruby Packages (rvm) - alternatives
#-----------------------------------------------------------------------------
# RUN ./root/.rvm/scripts/gem install bundler \
#     && ./root/.rvm/scripts/gem install rails \
#     && ./root/.rvm/scripts/gem install rspec \
#     && ./root/.rvm/scripts/gem install serverspec \
#     && ./root/.rvm/scripts/gem install docker-api \
#     && ./root/.rvm/scripts/gem install sqlite3 \
#     && ./root/.rvm/scripts/gem install mongoid \
#     && ./root/.rvm/scripts/gem install sequel \
#     && ./root/.rvm/scripts/gem install pg \
#     && ./root/.rvm/scripts/gem install mysql2 \
#     && ./root/.rvm/scripts/gem install sequel_pg \
#     && ./root/.rvm/scripts/gem install apktools \
#     && ./root/.rbenv/shims/gem install rubocop


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
