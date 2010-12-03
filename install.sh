#!/bin/bash

DIRS="vim vimbackup"
DEPS="pylint python ctags"

echo "] For best results, install vim with your package manager first."

echo "] Checking deps..."
for DEP in $DEPS;
do
    D=$(which $DEP)
    if [ "$D" == "" ]; then
        echo "] - Missing Dependancy -- $DEP!"
        exit 1
    fi
done

echo "] Installing directories..."
for DIR in $DIRS;
do
    echo "] - $HOME/$DIR"
    cp -r ./$DIR "$HOME/.$DIR"
done

echo "] Installing .vimrc to $HOME/.vimrc"
cp ./vimrc $HOME/.vimrc

echo "] Building vim with python"
cd vim7-src
./configure --enable-pythoninterp
make
