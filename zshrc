# zmodload zsh/zprof
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# source ~/antibody.zsh
source ~/.zsh_plugins.sh

source ~/.bash_aliases

bindkey '^ ' autosuggest-execute

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=bold,underline"
ZSH_AUTOSUGGEST_USE_ASYNC=true

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
export PATH="$PATH:$HOME/.local/bin"

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

eval enable-fzf-tab

() {
  local z=$'\0'
  PROMPT='${${${$(spaceship_prompt)//\%\%/'$z'}//\%B}//'$z'/%%}'
}

# source <(antibody init)

# antibody bundle < ~/.zsh_plugins.txt

# # Tell antibody that you're done
# antibody apply
# zprof
