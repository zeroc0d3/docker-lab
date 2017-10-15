#!/bin/sh

### Path Ruby RBENV / RVM ###
export RBENV=/usr/local/rbenv
export RVM=/usr/local/rvm

### rbenv (Ruby) default ###
export PATH="$RBENV/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$RBENV/plugins/ruby-build/bin:$PATH"
# export RAILS_ENV=staging

### rvm (Ruby) - alternative ###
# export PATH="$PATH:$RVM/bin"
# source $RVM/scripts/rvm

# Set PATH alternatives using this:
# [[ -s "$RVM/scripts/rvm"  ]] && source "$RVM/scripts/rvm"

### rvm selector ###
# function gemdir {
#   if [[ -z "$1" ]] ; then
#     echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
#   else
#     rvm "$1"
#     cd $(rvm gemdir)
#     pwd
#   fi
# }