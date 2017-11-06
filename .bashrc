#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\[\e[2;34m\]\$(date +%H:%M:%S)\[\e[m\] \[\e[1;30m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[02;33m\]\$(parse_git_branch)\[\e[m\] \[\e[1;32m\]\$\[\e[m\] "

# Up/down arrow key searches through input command
bind '"\e[A": history-search-backward'

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias v='vim'
alias g='git'

# Do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

# Confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Create parent directories on demand
alias mkdir='mkdir -pv'
