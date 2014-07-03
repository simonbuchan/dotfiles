# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="kardan"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(vi-mode ruby rake node npm bower python pip z zsh_reload)

source $ZSH/oh-my-zsh.sh

# User configuration
unsetopt autocd

if [ -e ~/.profile ]; then
    . ~/.profile
fi

# http://paulgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/
vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

# get the name of the branch we are on
function git_prompt_info() {
  local REF=$(command git symbolic-ref HEAD --short 2> /dev/null)
  REF=${REF:-$(command git describe --all --always --long 2> /dev/null)}
  if [[ -z $REF ]] return 0
  REF=${REF#heads/}; REF=${REF#remotes/}
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$REF$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Fix dirty flag with git config status.branch set
parse_git_dirty() {
  local FLAGS='--short'
  local STATUS=''
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
    FLAGS='--porcelain --ignore-submodules=dirty'
  fi
  if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
    FLAGS+=' -uno'
  fi
  STATUS=$(command git status $FLAGS 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

PROMPT='${vim_mode}> '
RPROMPT='%~$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="‖"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

KEYTIMEOUT=10

