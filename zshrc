ZSH_THEME="frisk"
DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git z)

source ~/.bash_aliases

source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then

  zgen oh-my-zsh
  zgen load urbainvaes/fzf-marks

  zgen save
fi

bindkey -v

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/usr/local/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export TERM=screen-256color
export EDITOR='nvim'
export VISUAL='nvim'
export FPP_EDITOR='nvim'
