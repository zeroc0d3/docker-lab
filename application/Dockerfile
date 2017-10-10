FROM zeroc0d3lab/centos-base-consul:latest
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
# Copy package dependencies in Gemfile
#-----------------------------------------------------------------------------
COPY ./rootfs/home/docker/Gemfile /home/docker/Gemfile
COPY ./rootfs/home/docker/Gemfile.lock /home/docker/Gemfile.lock

#-----------------------------------------------------------------------------
# Install Ruby Packages (rbenv/rvm)
#-----------------------------------------------------------------------------
COPY ./rootfs/home/docker/gems.sh /home/docker/gems.sh
RUN chmod a+x /home/docker/gems.sh \
    && ./home/docker/gems.sh

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
