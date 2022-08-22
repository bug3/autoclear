#!/bin/bash

preexec () {
  clear

  if [[ $1 != "" ]]; then
    echo -e "\033[36m\033[4m$1\n\033[0m"
    
    [[ "$PS1" =~ "\n".* ]] || export PS1="\n$PS1"
  fi
}

exec_last_command () {
    [ -n "$COMP_LINE" ] && return
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return
    
    local lastCommand=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g"`;

    preexec "$lastCommand"
}

trap 'exec_last_command' DEBUG
