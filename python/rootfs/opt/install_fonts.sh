#!/usr/bin/env sh

#-----------------------------------------------------------------------------
# Install Font Config
#-----------------------------------------------------------------------------
mkdir -p $HOME/.fonts \
  && mkdir -p $HOME/.config/fontconfig/conf.d/ \
  && mkdir -p /usr/share/fonts/local \
  && wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -O $HOME/.fonts/PowerlineSymbols.otf \
  && wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -O $HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf \
  && cp $HOME/.fonts/PowerlineSymbols.otf /usr/share/fonts/local/PowerlineSymbols.otf \
  && cp $HOME/.fonts/PowerlineSymbols.otf /usr/share/fonts/PowerlineSymbols.otf \
  && cp $HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf /etc/fonts/conf.d/10-powerline-symbols.conf \
  && /usr/bin/fc-cache -vf $HOME/.fonts/ \
  && /usr/bin/fc-cache -vf /usr/share/fonts