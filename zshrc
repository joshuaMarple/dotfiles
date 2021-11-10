# Uncomment this and comment at bottom to profile zsh load time
# zmodload zsh/zprof

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

skip_global_compinit=1
autoload -Uz compinit
# if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
# 	compinit;
# else
# 	compinit -C;
# fi;
compinit -C

source ~/.zsh_plugins.sh

source ~/.bash_aliases

compinit;


bindkey '^ ' autosuggest-execute

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=bold,underline"
ZSH_AUTOSUGGEST_USE_ASYNC=true

bindkey -v

bindkey '^P' fuzzy-search-and-edit

bindkey '^O' repl-set

SPACESHIP_TIME_SHOW=true
SPACESHIP_VI_MODE_INSERT=""
SPACESHIP_VI_MODE_NORMAL="[NORMAL]"
SPACESHIP_VI_MODE_COLOR="red"

SPACESHIP_PROMPT_ORDER=(
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
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  time          # Time stamps section
  vi_mode       # Vi-mode indicator
  line_sep      # Line break
  char          # Prompt character
)

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.local/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export TERM=vte-256color

if [ -z "$VISUAL" ]
then
	export EDITOR='nvim'
	export VISUAL='nvim'
	export FPP_EDITOR='nvim'
fi

autoload -z edit-command-line 
zle -N edit-command-line
bindkey "^v" edit-command-line

bindkey -s '^e' 'vim $(fzf)\n'
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"

# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

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

# Completion for kitty (disabled due to impact on startup times)
# kitty + complete setup zsh | source /dev/stdin

eval "$(zoxide init zsh)"

export BAT_THEME="ansi-light"

setopt +o nomatch

# zprof
