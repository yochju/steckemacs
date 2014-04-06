#!/bin/bash -e

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

trap "rm -rf ~/.emacs.d/" EXIT

if [ "$USER" == "vagrant" ]; then
    dir=/vagrant
else
    dir="$PWD"
fi

if ! dpkg -l | grep python-software-properties; then
    sudo apt-get update
    sudo apt-get install -qq python-software-properties
fi

if ! grep cassou /etc/apt/sources.list.d/*; then
    sudo add-apt-repository -y ppa:cassou/emacs
    sudo apt-get update
fi

if ! dpkg -l | grep emacs24; then
    sudo apt-get install -qq git mercurial subversion bzr cvs emacs-snapshot-el emacs-snapshot-gtk emacs-snapshot
fi

emacs-snapshot --batch --load $dir/.emacs
