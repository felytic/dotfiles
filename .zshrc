# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

setopt PROMPT_SUBST

# Up/down arrow key searches through input command
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# ============================ FUNCTIONS ======================================

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# Activate/deactivate virtualenv on entering/leaving a dir
function cd() {
  builtin cd $@

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./venv ]] ; then
        source ./venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}

venv() {
  if [[ -z "$VIRTUAL_ENV" ]] ; then
      echo '%F{blue}%K{yellow}%f'
  else
      echo '%F{blue}%K{green}%f%K{green}%F{black}' ${VIRTUAL_ENV##*/}'%f%k%F{green}%K{yellow}%f'
  fi
}

PROMPT='%B%K{blue}%F{white}%~%f%k%b$(venv)%K{yellow}%F{black} $(git_branch)%f%k%F{yellow}%f '
RPROMPT='%F{magenta}%T%f [%(?.%F{green}.%F{red})%?%f]'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias v='nvim'
alias n='node'
alias g='git'
alias r='ranger'

# Confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

alias py='bpython'

autoload -Uz promptinit
promptinit

# Set breakpoint() in Python to call pudb
export PYTHONBREAKPOINT="pudb.set_trace"
