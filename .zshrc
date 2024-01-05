# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

fpath+=~/.zfunc
autoload -Uz compinit
compinit

setopt PROMPT_SUBST

# Don't save duplicates in zsh history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Up/down arrow key searches through input command
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# del, home and end
bindkey "\e[3~" delete-char
bindkey "\e[H"  beginning-of-line
bindkey "\e[F"  end-of-line

# Use Ctrl+HJKL for navigation
bindkey "^k" history-beginning-search-backward
bindkey "^j" history-beginning-search-forward
bindkey "^h" backward-char
bindkey "^l" forward-char

bindkey "^b" beginning-of-line
bindkey "^e" end-of-line

# ============================ FUNCTIONS ======================================

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# Activate/deactivate virtualenv on entering/leaving a dir
function cd() {
  builtin cd $@

  # Check if a .env file exists in the current directory
    if [ -f .env ]; then
        source .env  # Source the .env file if it exists
    fi

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.venv ]] ; then
        source ./.venv/bin/activate
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
RPROMPT='%F{magenta}%*%f [%(?.%F{green}.%F{red})%?%f]'

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
alias g='git'
alias r='ranger'

# Confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

alias py='python -m ptpython'

alias update-system="yay -Syyu --overwrite '*'"
alias remove-unused-packages="yay -Rs $(yay -Qdtq)"

alias da="data-adapters"

autoload -Uz promptinit
promptinit

# Set alacritty as default terminal
export TERMINAL=alacritty
export TERM=alacritty

# Set breakpoint() in Python to call pudb
export PYTHONBREAKPOINT="pudb.set_trace"
export VIRTUAL_ENV_DISABLE_PROMPT=1

export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1

export LD_LIBRARY_PATH=/usr/local/lib
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
