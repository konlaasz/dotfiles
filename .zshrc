#
# ~/.zshrc
#
# vim:ft=sh:ts=4:sw=4:sts=4:fdm=marker

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=50001
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

setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

EDITOR=vim
VISUAL=$EDITOR
BROWSER=firefox

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward

# Sourced files {{{

# git prompt script
[ -r /usr/share/git/completion/git-prompt.sh ] && . /usr/share/git/completion/git-prompt.sh

# fzf completion and key bindings
[ -r /usr/share/fzf/completion.zsh ] && . /usr/share/fzf/completion.zsh
[ -r /usr/share/fzf/key-bindings.zsh ] && . /usr/share/fzf/key-bindings.zsh

# }}}

# Prompt {{{

# Regular prompt
precmd () { __git_ps1 " %F{green}%1~%b%f" "%s " }
RPROMPT='[%F{white}%?%f]'

# Red root prompt (this needs to go in /root/.zshrc)
if [ $(id -u) -eq 0 ]; then
    PROMPT='%B%F{red}%n%f%b:%F{magenta}%~%f%b '
    RPROMPT='[%F{white}%?%f]'
fi

# Grey ssh prompt
if [ "$SSH_CONNECTION" ]; then
    PROMPT='[%B%F{black}%n@%M%f%b:%F{green}%~%f%b] '
    RPROMPT='[%F{white}%?%f]'
fi

# }}}

# conf (.dotfiles git repo) {{{

# src: https://www.atlassian.com/git/tutorials/dotfiles
# src: https://news.ycombinator.com/item?id=11071754
# see: https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles

alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# }}}

# ranger {{{

# Set config variables
export RANGER_LOAD_DEFAULT_RC=false
export TERMCMD=urxvt
export PYGMENTIZE_STYLE=zenburn
export PYTHONOPTIMIZE=2

# Prepend (R) to right side prompt if ranger is running
[ -n "$RANGER_LEVEL" ] && RPROMPT='(R) '"$RPROMPT"

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
bindkey -s '^o' ' ranger-cd\n'

# }}}
