#!/bin/bash

preexec () {
  clear

  echo -e "\e[36m\e[4m$1\e[0m"
  echo ""
}

exec_last_command () {
    [ -n "$COMP_LINE" ] && return
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return
    
    local lastCommand=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g"`;

    preexec "$lastCommand"
}

trap 'exec_last_command' DEBUG
