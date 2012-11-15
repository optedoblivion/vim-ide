#!/bin/bash

# Required programs
REQUIRED="hg pylint python ctags"
for name in $(echo $REQUIRED);
do
    type -P "$name" &>/dev/null || { echo "Dependancy missing! Please install '$name'!" >&2; exit 1;}
done

# Plugin/Config files
PLUGIN_DIR="vim"
RCFILE="vimrc"

# Install configs
cp -r vim ~/.vim
cp vimrc ~/.vimrc
mkdir -p ~/.vimbackup/swap

# Fetch VIM sources
hg clone https://vim.googlecode.com/hg/ vim-src

# Change directory
cd vim-src

# Update
hg pull
hg update

# Build with Python
PROC="$(cat /proc/cpuinfo | grep proc | wc -l)"
./configure --enable-pythoninterp
make -j "$PROC"
sudo make install
