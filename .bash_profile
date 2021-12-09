#
# ~/.bash_profile
#
# vim:ft=sh:ts=2:sw=2:sts=2:et

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/.local/bin

# X login on tty1 (using startx - xinit doesn't read xserverrc)
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# wayland
#[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec cage -d firefox
#[ "$(tty)" = "/dev/tty2" ] && exec sway
