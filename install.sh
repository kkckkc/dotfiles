#!/bin/bash

mkdir -p $HOME/.config/gh

ln -s $HOME/dotfiles/.p10k.zsh $HOME/.p10k.zsh
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/gh/config.yml $HOME/.config/gh/config.yml
