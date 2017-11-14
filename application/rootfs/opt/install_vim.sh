#!/usr/bin/env sh

DATE=`date '+%Y-%m-%d %H:%M:%S'`
DEFAULT_VERSION='8.0.1207'
DEFAULT_LUA='5.3.4'
DEFAULT_LUAROCKS='2.4.3'
INSTALL_VERSION=$DEFAULT_VERSION
INSTALL_LUA=$DEFAULT_LUA
INSTALL_LUAROCKS=$DEFAULT_LUAROCKS
USERNAME=`echo $USER`
PATH_HOME=`echo $HOME`

logo() {
  echo "--------------------------------------------------------------------------"
  echo "  __________                  _________ _______       .___________        "
  echo "  \____    /___________  ____ \_   ___ \\   _  \    __| _/\_____  \  LAB  "
  echo "    /     // __ \_  __ \/  _ \/    \  \//  /_\  \  / __ |   _(__  <       "
  echo "   /     /\  ___/|  | \(  <_> )     \___\  \_/   \/ /_/ |  /       \      "
  echo "  /_______ \___  >__|   \____/ \______  /\_____  /\____ | /______  /      "
  echo "          \/   \/                     \/       \/      \/        \/       "
  echo "--------------------------------------------------------------------------"
  echo " Date / Time: $DATE"
}

check_version() {
  if [ "${VIM_VERSION}" != "" ]
  then
    INSTALL_VERSION=${VIM_VERSION}   
  fi
}

check_lua() {
  if [ "${LUA_VERSION}" != "" ]
  then
    INSTALL_LUA=${LUA_VERSION}   
  fi
}

check_luarocks() {
  if [ "${LUAROCKS_VERSION}" != "" ]
  then
    INSTALL_LUAROCKS=${LUAROCKS_VERSION}   
  fi
}

install_lua() {
  echo "--------------------------------------------------------------------------"
  echo "## Install Lua Version: "
  echo "   $INSTALL_LUA"
  echo "## Install Luarocks Version: "
  echo "   $INSTALL_LUAROCKS"

  #-----------------------------------------------------------------------------
  # Get repo lua & luarocks
  #-----------------------------------------------------------------------------
  curl -L http://www.lua.org/ftp/lua-$INSTALL_LUA.tar.gz -o /opt/lua-$INSTALL_LUA.tar.gz \
      && curl -L http://luarocks.github.io/luarocks/releases/luarocks-$INSTALL_LUAROCKS.tar.gz \
         -o /opt/luarocks-$INSTALL_LUAROCKS.tar.gz

  #-----------------------------------------------------------------------------
  # Install lua & luarocks
  #-----------------------------------------------------------------------------
  cd /opt \
      && tar zxvf lua-$INSTALL_LUA.tar.gz \
      && tar zxvf luarocks-$INSTALL_LUAROCKS.tar.gz \
      && cd lua-$INSTALL_LUA \
      && make linux \
      && cd ../luarocks-$INSTALL_LUAROCKS \
      && ./configure \
      && make \
      && sudo make install
}

install_vim() {
  echo "--------------------------------------------------------------------------"
  echo "## Install Vim Version: " 
  echo "   $INSTALL_VERSION"
  echo "## Using Lua: "
  echo "   $INSTALL_LUA"
  echo "## Using Luarocks: "
  echo "   $INSTALL_LUAROCKS"
  echo ""

  #-----------------------------------------------------------------------------
  # Download & Install
  # -) vim
  # -) vundle + themes
  #-----------------------------------------------------------------------------
  rm -rf $PATH_HOME/vim \
      && git clone https://github.com/vim/vim.git $PATH_HOME/vim \
      && cd $PATH_HOME/vim \
      && git checkout v$INSTALL_VERSION \
      && cd src \
      && make autoconf \
      && ./configure \
      && make distclean \
      && make \
      && cp config.mk.dist auto/config.mk \
      && sudo make install \
      && sudo mkdir -p /usr/share/vim \
      && sudo mkdir -p /usr/share/vim/vim80/ \
      && sudo cp -fr $PATH_HOME/vim/runtime/** /usr/share/vim/vim80/

  curl -sSL https://raw.githubusercontent.com/zeroc0d3/vim-ide/master/step02.sh | sudo bash -s

  git clone https://github.com/dracula/vim.git /opt/vim-themes/dracula \
      && git clone https://github.com/blueshirts/darcula.git /opt/vim-themes/darcula \
      && mkdir -p $PATH_HOME/.vim/bundle/vim-colors/colors \
      && cp /opt/vim-themes/dracula/colors/dracula.vim $PATH_HOME/.vim/bundle/vim-colors/colors/dracula.vim \
      && cp /opt/vim-themes/darcula/colors/darcula.vim $PATH_HOME/.vim/bundle/vim-colors/colors/darcula.vim

  tar zcvf vim.tar.gz $PATH_HOME/vim $PATH_HOME/.vim \
      && mv vim.tar.gz /opt
}

main() {
  logo
  check_version
  check_lua
  check_luarocks
  install_lua
  install_vim
}

### START HERE ###
main
