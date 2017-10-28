#!/bin/sh

WHAT_SHELL=`$SHELL -c 'echo $0'`
if [ "$WHAT_SHELL" = "`which zsh`" ] || [ "$WHAT_SHELL" = "zsh" ]
then  
  echo "ZSH"
  ### source ~/.zshrc
  exec $SHELL
else
  if [ "$WHAT_SHELL" = "`which bash`" ] || [ "$WHAT_SHELL" = "bash" ]
  then
    echo "BASH"
    source ~/.bashrc
    ### exec $SHELL
  else 
    echo "OTHER"
    ### source ~/.bashrc
    exec $SHELL
  fi
fi
# exit