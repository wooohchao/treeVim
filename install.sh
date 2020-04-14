#!/bin/sh
set -e

cd ~/treeVim

echo '
set runtimepath+=~/treeVim

source ~/treeVim/vimrcs/basic.vim
source ~/treeVim/vimrcs/filetypes.vim
source ~/treeVim/vimrcs/plugins_config.vim
source ~/treeVim/vimrcs/extended.vim
source ~/treeVim/vimrcs/color.vim
' > ~/.vimrc

echo "Installed the Vim configuration successfully! Enjoy :-)"
