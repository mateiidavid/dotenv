#!/bin/bash

REPO_PATH=${1:-$(pwd)}
INSTALL_PATH=${2:-~/.config/nvim}
set -eu

echo 'Setting up directories...'
mkdir -p $INSTALL_PATH/plugin
mkdir -p $INSTALL_PATH/lua

echo "Symlinking files from ${REPO_PATH} to ${INSTALL_PATH}..."
files=$(find . | grep -e '.*\.vim$')
for f in $files; do
	echo "Linking $f"
	rm -rf $INSTALL_PATH/$f
	ln -s $REPO_PATH/$f $INSTALL_PATH/$f
done
files=$(find . | grep -e '.*\.lua$')
for f in $files; do
	echo "Linking $f"
	rm -rf $INSTALL_PATH/$f
	ln -s $REPO_PATH/$f $INSTALL_PATH/$f
done
echo "Done!"

