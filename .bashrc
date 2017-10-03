#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
exitstatus()
{
    if [[ $? == 0 ]]; then
        echo ':)'
    else
        echo 'D:'
    fi
}
PS1='\[\e[1;30m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0m\]'
