#!/bin/sh
# .bashrc

# Aliases are not expanded when the shell is not interactive, unless the
# expand_aliases shell option is set using shopt. This is useful if having ssh
# execute a command.
shopt -s expand_aliases

#################################################################################
# Source global definitions
#################################################################################
# Comment out cause there is nothing that is pulled in that I need.
#if [ -f /etc/bashrc ]; then
#   source  /etc/bashrc
#fi


#################################################################################
# Source in all aliases unless the end in .org
#################################################################################
for i in $( ls $HOME/.aliases.*); do
    if [[ ! "${i##*.}" == org ]]
    then
        source $i
    fi
done

#################################################################################
# Source in various other aliases
#################################################################################
# For private aliases that will only reside on this machine
if [ -f $HOME/.bashrc.priv ]; then
    source $HOME/.bashrc.priv
fi




