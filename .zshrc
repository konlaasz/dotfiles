#
# ~/.zshrc
#
# vim:ft=zsh:ts=4:sw=4:sts=4:fdm=marker

EDITOR=vim
VISUAL=$EDITOR
BROWSER=firefox

# Vi mode
bindkey -v
export KEYTIMEOUT=1

setopt AUTO_PUSHD EXTENDEDGLOB NO_BEEP NOMATCH NOTIFY

# Disable ^s and ^q
stty stop undef
stty start undef

# Disable highlighting of pasted text
zle_highlight=('paste:none')

# Completion {{{

zstyle ':completion:*' menu select
#zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
#zstyle ':completion:*' verbose true
# Needed by git-completion.zsh
zstyle ':completion:*:*:git:*' script /usr/share/git/completion/git-completion.bash
fpath=(~/.local/share/zsh/functions $fpath)
autoload -Uz compinit
zmodload zsh/complist
compinit

# Include hidden files
_comp_options+=(globdots)

# Use Vi keys for navigating the completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# }}}

# History {{{

HISTFILE=~/.zsh_history
HISTSIZE=50001
SAVEHIST=50000

setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# }}}

# Aliases {{{

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias less='less -i'
alias ls='ls --color=auto'
alias pgrep='pgrep -afl'
alias ping='ping -c 3'

# }}}

# Cursor {{{

# Use grey cursor in command mode
# (Colors are from ~/.xrdb/look-zenburn.xrdb)
zle-keymap-select zle-line-init () {
    case $KEYMAP in
        vicmd)      print -n -- '\e]12;#8F8F8F\a';;
        viins|main) print -n -- '\e]12;#DCDCCC\a';;
    esac
    zle reset-prompt
}

# Reset color for next command
zle-line-finish () {
    print -n -- '\e]12;#DCDCCC\a'
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# }}}

# Prompt {{{

# Git prompt script
[ -r ~/.git-prompt.sh ] && . ~/.git-prompt.sh
# Color git prompt
GIT_PS1_SHOWCOLORHINTS=true
# Notify about unstaged (*) and staged (+) changes
GIT_PS1_SHOWDIRTYSTATE=true
# Notify about stashes ($)
GIT_PS1_SHOWSTASHSTATE=true
# Notify about untracked (%)
GIT_PS1_SHOWUNTRACKEDFILES=true

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

# Syntax highlighting {{{

[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# }}}

# Vim buffer {{{

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line
bindkey -M viins '^e' edit-command-line

# }}}

# conf (.dotfiles git repo) {{{

# src: https://www.atlassian.com/git/tutorials/dotfiles
# src: https://news.ycombinator.com/item?id=11071754
# see: https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles

alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# }}}

# fzf {{{

[ -r /usr/share/fzf/completion.zsh ] && . /usr/share/fzf/completion.zsh
[ -r /usr/share/fzf/key-bindings.zsh ] && . /usr/share/fzf/key-bindings.zsh

# Rebind ^R to redo in vicmd mode
bindkey -M vicmd -r "^R"
bindkey -M vicmd "^R" redo

# Use ! in vicmd mode
# TODO: stop eating the last character
bindkey -M vicmd '!' fzf-history-widget

#}}}

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
