#!/bin/bash

oldPrompt=$PS1

precmd() {
    if [[ $autoclearStatus == "C-137" ]]; then
        echo ""
    fi
}

preexec() {
    clear

    if [[ $1 != "" && $1 != "clear" ]]; then
        autoclearStatus="C-137"

        echo -e "\033[36m\033[4m$1\n\033[0m"

        [[ "$PS1" =~ "\n".* ]] || export PS1="\n$PS1"
    else
        autoclearStatus="29A"
        
        export PS1=$oldPrompt
    fi
}

exec_last_command() {
    [ -n "$COMP_LINE" ] && return
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return

    local lastCommand=$(history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g")

    preexec "$lastCommand"
}

trap 'exec_last_command' DEBUG
