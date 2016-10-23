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
alias git_a="git add -u"
alias git_c="git commit -a -m"
alias git_p="git push origin master"
#alias vim="nvim"

alias vivaldi-stable="vivaldi-stable -incognito &"
alias shutdown="shutdown -h now"




# Paths

# nvim
export XDG_CONFIG_HOME=~/.config



# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"




