#!/bin/sh

DATE=`date '+%Y-%m-%d %H:%M:%S'`

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

load_env() {
  echo "--------------------------------------------------------------------------"
  echo "## Load Environment: "
  echo "   $HOME/.bashrc"
  source ~/.bashrc
  exec $SHELL
}

check(){
  echo "--------------------------------------------------------------------------"
  echo "## Ruby Version: "
  RUBY=`which ruby`
  RUBY_V=`$RUBY -v`
  echo "   $RUBY_V"
  echo "--------------------------------------------------------------------------"
  echo "## Path Ruby: "
  echo "   $RUBY"
  echo "--------------------------------------------------------------------------"
  echo "## Path Gem: "
  GEM=`which gem`
  echo "   $GEM"
}

install_bundle() {
  echo "--------------------------------------------------------------------------"
  echo "## Install Bundle: "
  echo "   $GEM install bundle"
  $GEM install bundle
}

install_package() {
  echo "--------------------------------------------------------------------------"
  echo "## Install Package: "
  BUNDLE=`which bundle`
  echo "   $BUNDLE install"
  $BUNDLE install
}

main() {
  logo
  load_env
  check
  install_bundle
  install_package
}

### START HERE ###
main