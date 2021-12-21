#
# ~/.bashrc
#
# vim:ft=sh:ts=2:sw=2:sts=2:fdm=marker

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# history {{{
#HISTFILE=/tmp/.bash_history_${USER}
HISTSIZE=500000
HISTFILESIZE=500000
HISTCONTROL=ignorespace:erasedups
HISTIGNORE='&:history*'
shopt -s histappend histreedit histverify
#set +o history
# }}}

# variables {{{
export EDITOR=vim
export VISUAL=$EDITOR
export BROWSER=firefox
export MPD_HOST=eta.home
export TERMINAL=urxvt
# }}}

# command prompt {{{

# regular prompt
#PS1='[\u@\h \W]\$ '
#PS1=' [\[\e[0;32m\]\W\[\e[0m\]$(__git_ps1 " (%s)")\]] '
#PS1='[\[\e[0;36m\]\u\[\e[0m\]:\[\e[0;32m\]\W\[\e[0m\]$(__git_ps1 " (%s)")] '
PS1=' \[\e[0;32m\]\W\[\e[0m\]$(__git_ps1 " (%s)") '

# red root prompt
if [ $(id -u) -eq 0 ]; then
    PS1='[\[\e[1;31m\]\u\[\e[0m\]:\[\e[0;35m\]\W\[\e[0m\]] '
fi

# grey ssh prompt
if [ "$SSH_CONNECTION" ]; then
    PS1='[\[\e[1;30m\]\u@\H\[\e[0m\]:\[\e[0;32m\]\W\[\e[0m\]] '
fi

# }}}

# sourced files {{{

# load aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# load functions
[ -f ~/.bash_functions ] && . ~/.bash_functions

# load git prompt script
[ -r /usr/share/git/completion/git-prompt.sh ] && . /usr/share/git/completion/git-prompt.sh

# }}}

# config (.dotfiles git repo) {{{
# src: https://www.atlassian.com/git/tutorials/dotfiles
# src: https://news.ycombinator.com/item?id=11071754
# see: https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
source /usr/share/bash-completion/completions/git
__git_complete config __git_main
# }}}

# ranger {{{
[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'(R) '

export PYTHONOPTIMIZE=2

function ranger-cd {
    if [ -z "$RANGER_LEVEL" ]
    then
	    tempfile='/tmp/chosendir'
	    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
	    test -f "$tempfile" &&
	    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
		cd -- "$(cat "$tempfile")"
	    fi
	    rm -f -- "$tempfile"
    else
        exit &>/dev/null
    fi
}

# This binds Ctrl-O to ranger-cd:
bind '"\C-o":" ranger-cd\C-m"'

# }}}
