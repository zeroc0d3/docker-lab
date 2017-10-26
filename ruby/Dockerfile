FROM zeroc0d3lab/centos-base-consul:latest
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
# Set Group & User for 'docker'
#-----------------------------------------------------------------------------
RUN mkdir -p ${PATH_HOME} \
    && groupadd docker \
    && useradd -r -g docker docker \
    && usermod -aG root docker \
    && chown -R docker:docker ${PATH_HOME} \
    && mkdir -p ${PATH_HOME}/git-shell-commands \
    && chmod 755 ${PATH_HOME}/git-shell-commands

#-----------------------------------------------------------------------------
# Find Fastest Repo & Update Repo
#-----------------------------------------------------------------------------
RUN curl -L https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo \
      -o /etc/yum.repos.d/mcepl-vim8-epel-7.repo

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
         vim* \

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
# Download & Install
# -) bash_it (bash + themes)
# -) oh-my-zsh (zsh + themes)
#-----------------------------------------------------------------------------
RUN rm -rf /root/.bash_it \
    && rm -rf /root/.oh-my-zsh \
    && touch /root/.bashrc \
    && touch /root/.zshrc \
    && cd /root \
    && git clone https://github.com/Bash-it/bash-it.git /opt/.bash_it \
    && git clone https://github.com/speedenator/agnoster-bash.git /opt/.bash_it/themes/agnoster-bash \
    && git clone https://github.com/robbyrussell/oh-my-zsh.git /opt/.oh-my-zsh \
    && git clone https://github.com/bhilburn/powerlevel9k.git /opt/.oh-my-zsh/custom/themes/powerlevel9k \
    && cd /opt  \
    && tar zcvf bash_it.tar.gz .bash_it \
    && tar zcvf oh-my-zsh.tar.gz .oh-my-zsh \
    && cp /opt/bash_it.tar.gz $HOME \
    && cp /opt/oh-my-zsh.tar.gz $HOME \
    && cd $HOME \
    && tar zxvf $HOME/bash_it.tar.gz \
    && tar zxvf oh-my-zsh.tar.gz

#-----------------------------------------------------------------------------
# Download & Install
# -) tmux + themes
#-----------------------------------------------------------------------------
RUN rm -rf /opt/tmux \
    && rm -rf $HOME/.tmux/plugins/tpm \
    && touch $HOME/.tmux.conf \
    && git clone https://github.com/tmux/tmux.git /opt/.tmux \
    && git clone https://github.com/tmux-plugins/tpm.git /opt/.tmux/plugins/tpm \
    && git clone https://github.com/seebi/tmux-colors-solarized.git /opt/.tmux-colors-solarized \
    && cd /opt  \
    && tar zcvf tmux.tar.gz .tmux \
    && cp /opt/tmux.tar.gz $HOME \
    && cd $HOME \
    && tar zxvf tmux.tar.gz

RUN cd $HOME/.tmux \
    && /bin/sh autogen.sh \
    && /bin/sh ./configure \
    && sudo make \
    && sudo make install

#-----------------------------------------------------------------------------
# Install Font Config
#-----------------------------------------------------------------------------
RUN mkdir -p $HOME/.fonts \
    && mkdir -p $HOME/.config/fontconfig/conf.d/ \
    && mkdir -p /usr/share/fonts/local \
    && wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -O $HOME/.fonts/PowerlineSymbols.otf \
    && wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -O $HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf \
    && cp $HOME/.fonts/PowerlineSymbols.otf /usr/share/fonts/local/PowerlineSymbols.otf \
    && cp $HOME/.fonts/PowerlineSymbols.otf /usr/share/fonts/PowerlineSymbols.otf \
    && cp $HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf /etc/fonts/conf.d/10-powerline-symbols.conf \
    && /usr/bin/fc-cache -vf $HOME/.fonts/ \
    && /usr/bin/fc-cache -vf /usr/share/fonts

#-----------------------------------------------------------------------------
# Download & Install
# -) dircolors (terminal colors)
#-----------------------------------------------------------------------------
RUN git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git /opt/.solarized \
    && cd /opt  \
    && tar zcvf solarized.tar.gz .solarized \
    && cp /opt/solarized.tar.gz $HOME \
    && cd $HOME \
    && tar zxvf solarized.tar.gz

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

#-----------------------------------------------------------------------------
# Clean Up All Cache
#-----------------------------------------------------------------------------
RUN yum clean all

#-----------------------------------------------------------------------------
# Download & Install
# -) lua
# -) luarocks
# -) vim
# -) vundle + themes
#-----------------------------------------------------------------------------
COPY ./rootfs/opt/install_vim.sh /opt/install_vim.sh
# RUN sudo /bin/sh /opt/install_vim.sh

#-----------------------------------------------------------------------------
# Install Lua
#-----------------------------------------------------------------------------
RUN curl -L http://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz -o /opt/lua-${LUA_VERSION}.tar.gz \
    && curl -L http://luarocks.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz \
         -o /opt/luarocks-${LUAROCKS_VERSION}.tar.gz

RUN cd /opt \
    && tar zxvf lua-${LUA_VERSION}.tar.gz \
    && tar zxvf luarocks-${LUAROCKS_VERSION}.tar.gz \
    && cd lua-${LUA_VERSION} \
    && make linux \
    && cd ../luarocks-${LUAROCKS_VERSION} \
    && ./configure \
    && make \
    && sudo make install
    
#-----------------------------------------------------------------------------
# Install Python 3.5
#-----------------------------------------------------------------------------
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
    && yum -y update \
    && yum -y install python35u python35u-libs python35u-devel python35u-pip 

#-----------------------------------------------------------------------------
# Clean Up All Cache
#-----------------------------------------------------------------------------
RUN yum clean all

#-----------------------------------------------------------------------------
# Install Lua
#-----------------------------------------------------------------------------
RUN curl -L http://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz -o /opt/lua-${LUA_VERSION}.tar.gz \
    && curl -L http://luarocks.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz \
         -o /opt/luarocks-${LUAROCKS_VERSION}.tar.gz

RUN cd /opt \
    && tar zxvf lua-${LUA_VERSION}.tar.gz \
    && tar zxvf luarocks-${LUAROCKS_VERSION}.tar.gz \
    && cd lua-${LUA_VERSION} \
    && make linux \
    && cd ../luarocks-${LUAROCKS_VERSION} \
    && ./configure \
    && make \
    && sudo make install

#-----------------------------------------------------------------------------
# Download & Install
# -) vim
# -) vundle + themes
#-----------------------------------------------------------------------------
RUN rm -rf /root/vim \
    && git clone https://github.com/vim/vim.git /root/vim \
    && cd /root/vim \
    && git checkout v${VIM_VERSION} \
    && cd src \
    && make autoconf \
    && ./configure \
    && make distclean \
    && make \
    && cp config.mk.dist auto/config.mk \
    && sudo make install \
    && sudo mkdir -p /usr/share/vim \
    && sudo mkdir -p /usr/share/vim/vim80/ \
    && sudo cp -fr /root/vim/runtime/** /usr/share/vim/vim80/

RUN curl -sSL https://raw.githubusercontent.com/zeroc0d3/vim-ide/master/step02.sh | sudo bash -s

RUN git clone https://github.com/dracula/vim.git /opt/vim-themes/dracula \
    && git clone https://github.com/blueshirts/darcula.git /opt/vim-themes/darcula \
    && mkdir -p /root/.vim/bundle/vim-colors/colors \
    && cp /opt/vim-themes/dracula/colors/dracula.vim /root/.vim/bundle/vim-colors/colors/dracula.vim \
    && cp /opt/vim-themes/darcula/colors/darcula.vim /root/.vim/bundle/vim-colors/colors/darcula.vim

RUN tar zcvf vim.tar.gz /root/vim /root/.vim \
    && mv vim.tar.gz /opt

#-----------------------------------------------------------------------------
# Setup TrueColors (Terminal)
#-----------------------------------------------------------------------------
COPY ./rootfs/root/colors/24-bit-color.sh /opt/24-bit-color.sh
RUN chmod a+x /opt/24-bit-color.sh; sync \
    && sudo /bin/sh /opt/24-bit-color.sh

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
# Cleanup 'root' folder
#-----------------------------------------------------------------------------
RUN rm -f /root/*.tar.gz \
    && rm -f /root/*.zip \
    && rm -f /opt/*.tar.gz \
    && rm -f /opt/*.zip

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
