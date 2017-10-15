FROM zeroc0d3lab/centos-application:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Set Environment
#-----------------------------------------------------------------------------
ENV RUBY_VERSION=2.3.0 \
    PATH_HOME=/home/docker \
    PATH_WORKSPACE=/home/docker/workspace

#-----------------------------------------------------------------------------
# Prepare Install Ruby
# -) copy .zshrc to /home/docker
# -) copy .bashrc to /home/docker
#-----------------------------------------------------------------------------
COPY ./rootfs/home/docker/.zshrc /home/docker/.zshrc
COPY ./rootfs/home/docker/.bashrc /home/docker/.bashrc

#-----------------------------------------------------------------------------
# Install Ruby with rbenv (default)
#-----------------------------------------------------------------------------
COPY ./rootfs/opt/rbenv.sh /etc/profile.d/rbenv.sh
RUN git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv \
    && git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
    && ./usr/local/rbenv/bin/rbenv install ${RUBY_VERSION} \
    && ./usr/local/rbenv/bin/rbenv global ${RUBY_VERSION} \
    && ./usr/local/rbenv/bin/rbenv rehash \
    && ./usr/local/rbenv/shims/ruby -v

#-----------------------------------------------------------------------------
# Install Ruby with rvm (alternatives)
#-----------------------------------------------------------------------------
# COPY ./rootfs/opt/rvm.sh /etc/profile.d/rvm.sh
# RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
#     && curl -sSL https://get.rvm.io | sudo bash -s stable \
#     && sudo usermod -a -G rvm root \
#     && sudo usermod -a -G rvm docker \
#     && ./usr/local/rvm/scripts/rvm install ${RUBY_VERSION} \
#     && ./usr/local/rvm/scripts/rvm use ${RUBY_VERSION} --default
#     && ./usr/bin/ruby -v

#-----------------------------------------------------------------------------
# Copy package dependencies in Gemfile
#-----------------------------------------------------------------------------
COPY ./rootfs/home/docker/Gemfile /opt/Gemfile
COPY ./rootfs/home/docker/Gemfile.lock /opt/Gemfile.lock

#-----------------------------------------------------------------------------
# Install Ruby Packages (rbenv/rvm)
#-----------------------------------------------------------------------------
COPY ./rootfs/home/docker/gems.sh /opt/gems.sh
# RUN chmod 777 /opt/gems.sh; sync \
#     chmod a+x /opt/gems.sh; sync \
#     && ./opt/gems.sh

#-----------------------------------------------------------------------------
# Install ImageMagick
#-----------------------------------------------------------------------------
RUN yum -y install \
           --setopt=tsflags=nodocs \
           --disableplugin=fastestmirror \
         ImageMagick \
         ImageMagick-devel \

#-----------------------------------------------------------------------------
# Clean Up All Cache
#-----------------------------------------------------------------------------
    && yum clean all

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
VOLUME ["/home/docker", "/home/docker/workspace", "/root"]

#-----------------------------------------------------------------------------
# Finalize (reconfigure)
#-----------------------------------------------------------------------------
COPY rootfs/ /

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
ENTRYPOINT ["/init"]
CMD []
