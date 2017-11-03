#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

alias ls='ls --color=auto'

PS1="\[\e[2;34m\]\$(date +%H:%M:%S)\[\e[m\] \[\e[1;30m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[02;33m\]\$(parse_git_branch)\[\e[m\] \[\e[1;32m\]\$\[\e[m\] "
