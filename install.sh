#!/usr/bin/env bash

#
# Install script for vimfiles
#

# Create symbolic links in the HOME directory for eligible files
pushd $(dirname $0)

for file in vimrc gvimrc vim
do
    ln -sfv "${PWD}/${file}" "${HOME}/.${file}"
done

popd

# Find dead symlinks and remove them
find ${HOME} -maxdepth 1 -xtype l | xargs -r rm
