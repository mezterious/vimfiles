#!/usr/bin/env bash

#
# Install script for vimfiles
#

# Get the absolute directory
source_dir_absolute=$(cd $(dirname $0) && pwd)

# Get directory relative to $HOME
source_dir_relative=".${source_dir_absolute#${HOME}}" 

# Create symlinks
for file in vimrc gvimrc vim
do
    base_file_name=$(basename ${file})
    ln -svf ${source_dir_relative}/${base_file_name} ${HOME}/.${base_file_name}
done
