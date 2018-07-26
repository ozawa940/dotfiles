#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# alias


# Paths

# nvim
if [ `which nvim` 2> /dev/null ]; then
    alias vim="nvim"
    export XDG_CONFIG_HOME=~/.config
    export TERM=xterm-256color
fi

# GO

if [ `which go` 2> /dev/null ]; then
    export GOPATH=$HOME/work/dev
    export PATH=$PATH:$GOPATH/bin


    function peco-src () {
      local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
      if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
      fi
      zle clear-screen
    }
    zle -N peco-src
    bindkey '^]' peco-src
fi

# anyenv
if [ `which anyenv` 2> /dev/null ]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi
