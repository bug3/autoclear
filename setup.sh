#!/bin/bash

toolName="autoclear"
fileName="$toolName.sh"
toolPath="/usr/share/$toolName"
toolComment="# $toolName tool"
profileCommand="source $toolPath/$fileName $toolComment"

install () {
    chmod u+x $fileName

    if [[ ! -e $toolPath ]]; then
        sudo mkdir $toolPath
    else
        echo "$toolPath already exists"
        exit 1
    fi

    sudo cp $fileName $toolPath

    echo -e "\n$profileCommand" >> ~/$shellrc
    sudo bash -c "echo -e '\n$profileCommand' >> $rootPath/$shellrc"
}

uninstall () {
    sudo rm $toolPath/$fileName

    sed -i "/$toolComment/d" ~/$shellrc
    sudo sed -i "/$toolComment/d" $rootPath/$shellrc
}

[[ -e ~/.bashrc ]] && shellrc=".bashrc" || shellrc=".bash_profile"
[[ "$OSTYPE" == "darwin"* ]] && rootPath="/var/root" || rootPath="/root"

if [ $# -eq 0 ]; then
	install
elif [ $1 == "-r" ]; then
	uninstall
fi

exec bash --login
