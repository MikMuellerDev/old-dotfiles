#!/bin/bash

install_file () {
    mkdir -p "$HOME/$(dirname "$1")"
    [[ ! -f ~/"$1" ]] || mv ~/"$1" ~/"$1".old
    [[ ! -L ~/"$1" ]] || rm ~/"$1"
    ln -s "$PWD/$1" "$HOME/$1"
}

install_file .zshrc
install_file .config/.aliasrc.zsh
install_file .tmux.conf
install_file .config/terminator/config
install_file .config/alacritty.yml
install_file .config/nvim/init.vim
