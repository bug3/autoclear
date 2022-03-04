#!/bin/bash

toolName="autoclear"
fileName="$toolName.sh"
toolPath="/usr/share/$toolName"
textEdit="append-remove.sh"

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

[[ -e ~/.bashrc ]] && shellrc=".bashrc" || shellrc=".bash_profile"
[[ "$OSTYPE" == "darwin"* ]] && rootPath="/var/root" || rootPath="/root"

source $textEdit ~/$shellrc

if [ $# -eq 0 ]; then
	install
elif [ $1 == "-r" ]; then
	uninstall
fi

exec bash --login
