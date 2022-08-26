#
# ~/.zshrc: Executed for interactive shells
#
# vim:ft=zsh:ts=4:sw=4:sts=4:fdm=marker

# Vi mode
bindkey -v
export KEYTIMEOUT=1

setopt AUTO_PUSHD EXTENDEDGLOB NO_BEEP NOMATCH NOTIFY

# Disable ^s and ^q
stty stop undef
stty start undef

# Disable highlighting of pasted text
zle_highlight=('paste:none')

precmd () {
    # Set window title
    print -Pn "\e]0;%~\a"
    # Generate prompt (including git info, if applicable)
    if [ "$SSH_CONNECTION" ]; then
        # Grey ssh prompt
        __git_ps1 "%B%F{black}%n@%M%f%b:%F{green}%~%f%b" "%s "
    else
        # Minimal regular prompt
        __git_ps1 " %F{green}%1~%b%f" "%s "
    fi
}

# Completion {{{

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' verbose true
zstyle ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:correct:*' insert-unambiguous true
zstyle ':completion:*:correct:*' original true
zstyle ':completion:*:corrections' format $'%{\e[1;37m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format $'%{\e[1;37m%}completing %B%d%b%{\e[0m%}'
autoload -Uz compinit
zmodload zsh/complist
compinit

# Git completion
fpath=(~/.local/share/zsh/functions/Completion $fpath)
# Do not include "DWIM" suggestions in git-checkout and git-switch completion.
GIT_COMPLETION_CHECKOUT_NO_GUESS=1
# Suggest all options, including options which are typically hidden.
GIT_COMPLETION_SHOW_ALL=1

# Include hidden files
_comp_options+=(globdots)

# Use Vi keys for navigating the completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# Use Esc to exit the completion menu
bindkey -M menuselect '^[' undo

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
alias less='less -iM'
alias ls='ls --color=auto'
alias pgrep='pgrep -afl'
alias ping='ping -c 3'

# }}}

# Cursor {{{

# Use grey cursor in command mode
# (Use colors from ~/.Xresources)
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

# PROMPT is set by precmd
RPROMPT='[%F{white}%?%f]'

# Git prompt script
[ -r ~/.git-prompt.sh ] && . ~/.git-prompt.sh
# Color git prompt
GIT_PS1_SHOWCOLORHINTS=true
# Notify about unstaged (*) and staged (+) changes
GIT_PS1_SHOWDIRTYSTATE=true
# Notify about stashes ($)
GIT_PS1_SHOWSTASHSTATE=true
# Notify about untracked files (%)
GIT_PS1_SHOWUNTRACKEDFILES=true

# }}}

# Syntax highlighting {{{

[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# }}}

# Vim buffer {{{

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M viins '^e' edit-command-line

# }}}

# conf (.dotfiles git repo) {{{

# src: https://www.atlassian.com/git/tutorials/dotfiles
# src: https://news.ycombinator.com/item?id=11071754
# see: https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles

alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# }}}

# fzf {{{

source ~/.local/share/fzf/completion.zsh
source ~/.local/share/fzf/key-bindings.zsh

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
    if [ -z "$RANGER_LEVEL" ]; then
        local TMP="$(mktemp /tmp/ranger.dir.XXXXXXXXXX)"
        /usr/bin/ranger --choosedir="$TMP" "${@:-${PWD}}"
        if [ -f "$TMP" ]; then
            local DIR="$(<"$TMP")"
            rm -f "$TMP"
            if [ -d "$DIR" ]; then
                if [ "$DIR" != "$PWD" ]; then
                    cd "$DIR"
                fi
            fi
        fi
    else
        exit
    fi
}

# Bind Ctrl-O to ranger-cd:
bindkey -s '^o' ' ranger-cd\n'

# }}}
