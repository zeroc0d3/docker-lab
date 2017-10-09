FROM zeroc0d3lab/centos-base-consul-lite:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Set Environment
#-----------------------------------------------------------------------------
ENV RUBY_MAJOR=2.4
ENV RUBY_VERSION=2.4.2
ENV GIT_HOME=/home/docker

USER root
#-----------------------------------------------------------------------------
# Set Group & User for 'docker'
#-----------------------------------------------------------------------------
RUN mkdir -p ${GIT_HOME} \
    && groupadd docker \
    && useradd -r -g docker docker \
    && usermod -aG docker docker \
    && chown -R docker:docker ${GIT_HOME} \
    && mkdir -p ${GIT_HOME}/git-shell-commands \
    && chmod 755 ${GIT_HOME}/git-shell-commands

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
# Prepare Install Ruby
# -) copy .zshrc to /home/docker
# -) copy .bashrc to /home/docker
#-----------------------------------------------------------------------------
COPY ./rootfs/home/docker/.zshrc /home/docker/.zshrc
COPY ./rootfs/home/docker/.bashrc /home/docker/.bashrc

#-----------------------------------------------------------------------------
# Setup TrueColors (Terminal)
#-----------------------------------------------------------------------------
COPY ./rootfs/home/docker/colors/24-bit-color.sh /home/docker/colors/24-bit-color.sh
RUN chmod +x /home/docker/colors/24-bit-color.sh \
    ./home/docker/colors/24-bit-color.sh

USER docker
#-----------------------------------------------------------------------------
# Install Ruby with rbenv (default)
#-----------------------------------------------------------------------------
RUN git clone https://github.com/rbenv/rbenv.git /home/docker/.rbenv \
    && git clone https://github.com/rbenv/ruby-build.git /home/docker/.rbenv/plugins/ruby-build \
    && ./home/docker/.rbenv/bin/rbenv install ${RUBY_VERSION} \
    && ./home/docker/.rbenv/bin/rbenv global ${RUBY_VERSION} \
    && ./home/docker/.rbenv/bin/rbenv rehash \
    && ./home/docker/.rbenv/shims/ruby -v

#-----------------------------------------------------------------------------
# Install Ruby with rvm (alternatives)
#-----------------------------------------------------------------------------
# RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
#     && curl -sSL https://get.rvm.io | bash -s stable \
#     && ./home/docker/.rvm/scripts/rvm install ${RUBY_VERSION} \
#     && ./home/docker/.rvm/scripts/rvm use ${RUBY_VERSION} --default
#     && ./usr/bin/ruby -v

#-----------------------------------------------------------------------------
# Install Ruby Packages (rbenv)
#-----------------------------------------------------------------------------
RUN ./home/docker/.rbenv/shims/gem install bundler \
    && ./home/docker/.rbenv/shims/gem install rails \
    && ./home/docker/.rbenv/shims/gem install rspec \
    && ./home/docker/.rbenv/shims/gem install serverspec \
    && ./home/docker/.rbenv/shims/gem install docker-api \
    && ./home/docker/.rbenv/shims/gem install sqlite3 \
    && ./home/docker/.rbenv/shims/gem install mongoid \
    && ./home/docker/.rbenv/shims/gem install sequel \
    && ./home/docker/.rbenv/shims/gem install pg \
    && ./home/docker/.rbenv/shims/gem install mysql2 \
    && ./home/docker/.rbenv/shims/gem install sequel_pg \
    && ./home/docker/.rbenv/shims/gem install apktools \
    && ./home/docker/.rbenv/shims/gem install rubocop

#-----------------------------------------------------------------------------
# Install Ruby Packages (rvm) - alternatives
#-----------------------------------------------------------------------------
# RUN ./home/docker/.rvm/scripts/gem install bundler \
#     && ./home/docker/.rvm/scripts/gem install rails \
#     && ./home/docker/.rvm/scripts/gem install rspec \
#     && ./home/docker/.rvm/scripts/gem install serverspec \
#     && ./home/docker/.rvm/scripts/gem install docker-api \
#     && ./home/docker/.rvm/scripts/gem install sqlite3 \
#     && ./home/docker/.rvm/scripts/gem install mongoid \
#     && ./home/docker/.rvm/scripts/gem install sequel \
#     && ./home/docker/.rvm/scripts/gem install pg \
#     && ./home/docker/.rvm/scripts/gem install mysql2 \
#     && ./home/docker/.rvm/scripts/gem install sequel_pg \
#     && ./home/docker/.rvm/scripts/gem install apktools \
#     && ./home/docker/.rbenv/shims/gem install rubocop

USER root
#-----------------------------------------------------------------------------
# Create Workspace Application Folder
#-----------------------------------------------------------------------------
RUN mkdir -p ${GIT_HOME}/workspace \
    mkdir -p /var/run/s6

#-----------------------------------------------------------------------------
# Fixing ownership for 'docker' user
#-----------------------------------------------------------------------------
RUN chown -R docker:docker ${GIT_HOME} 

#-----------------------------------------------------------------------------
# Set PORT Docker Container
#-----------------------------------------------------------------------------
EXPOSE 22

#-----------------------------------------------------------------------------
# Set Volume Application
#-----------------------------------------------------------------------------
VOLUME ["/home", "/root"]

#-----------------------------------------------------------------------------
# Finalize (reconfigure)
#-----------------------------------------------------------------------------
COPY rootfs/ /

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
ENTRYPOINT ["/init"]
CMD []
