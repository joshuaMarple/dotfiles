HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

autoload -Uz compinit
compinit

source ~/antigen.zsh

antigen theme denysdovhan/spaceship-prompt

antigen bundle git
antigen bundle Aloxaf/fzf-tab
antigen bundle command-not-found

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle urbainvaes/fzf-marks
antigen bundle mafredri/zsh-async
antigen bundle zsh-users/zsh-autosuggestions

# Tell Antigen that you're done
antigen apply


source ~/.bash_aliases

bindkey '^ ' autosuggest-execute

bindkey -v

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  #elixir        # Elixir section
  #xcode         # Xcode section
  #swift         # Swift section
  #golang        # Go section
  #php           # PHP section
  #rust          # Rust section
  #haskell       # Haskell Stack section
  #julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  #dotnet        # .NET section
  #ember         # Ember.js section
  #kubectl       # Kubectl context section
  #terraform     # Terraform workspace section
  exec_time     # Execution time
  battery       # Battery level and status
  #vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  line_sep      # Line break
  char          # Prompt character
)

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/usr/local/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export TERM=screen-256color
export EDITOR='nvim'
export VISUAL='nvim'
export FPP_EDITOR='nvim'

bindkey -s '^e' 'vim $(fzf)\n'
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"

# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/%}"
}

# define right prompt, regardless of whether the theme defined it
RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

#source ~/./
eval enable-fzf-tab
