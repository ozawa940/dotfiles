#!/bin/bash
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

bash ~/dotfiles/insvim.sh

if [-e /bin/zsh]; then
    zsh ~/dotfiles/inszprezto.sh
fi

