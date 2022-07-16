#
# ~/.zshrc
#
# vim:ft=sh:ts=4:sw=4:sts=4:fdm=marker

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=50000
setopt extendedglob nomatch notify
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/konl/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# config (.dotfiles git repo) {{{

# src: https://www.atlassian.com/git/tutorials/dotfiles
# src: https://news.ycombinator.com/item?id=11071754
# see: https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# }}}

# ranger {{{

# Set config variables
export RANGER_LOAD_DEFAULT_RC=false
export TERMCMD=urxvt
export PYGMENTIZE_STYLE=zenburn
export PYTHONOPTIMIZE=2

# Add (R) to prompt if ranger is running
[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'(R) '

# Use ranger to switch directories
ranger-cd () {
    if [ -z "$RANGER_LEVEL" ]
    then
        tmp="$(mktemp)"
        /usr/bin/ranger --choosedir="$tmp" "${@:-$(pwd)}"
        if [ -f "$tmp" ]; then
            dir="$(cat "$tmp")"
            rm -f "$tmp"
            [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
        fi
    else
        exit &>/dev/null
    fi
}

# Bind Ctrl-O to ranger-cd:
bindkey -s '^o' 'ranger-cd\n'

# }}}
