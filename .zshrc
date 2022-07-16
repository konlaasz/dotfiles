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
