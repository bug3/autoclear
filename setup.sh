#!/bin/bash

toolName="autoclear"
fileName="$toolName.sh"
toolPath="/usr/share/$toolName"
textEdit="append-remove.sh"
finishMessage="Restart the console to apply changes"

install () {
    chmod u+x $fileName

    if [[ ! -e $toolPath ]]; then
        sudo mkdir $toolPath
    else
        echo "$toolPath already exists"
        exit 1
    fi

    sudo cp $fileName $toolPath

    appendText
    sudo bash -c "source $textEdit $rootPath/$shellrc; appendText"
}

uninstall () {
    sudo rm -r $toolPath

    removeText
    sudo bash -c "source $textEdit $rootPath/$shellrc; removeText"
}

[[ "$OSTYPE" == "darwin"* ]] && rootPath="/var/root" || rootPath="/root"

source $textEdit ~/$shellrc

if [ $# -eq 0 ]; then
	install
elif [ $1 == "-r" ]; then
	uninstall
fi

echo -e "\033[31m\033[1m$finishMessage\033[0m"
