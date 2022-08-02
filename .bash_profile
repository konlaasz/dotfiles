#
# ~/.bash_profile
#
# vim:ft=sh:ts=2:sw=2:sts=2:et

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/.local/bin

# X login on tty1 (using startx - xinit doesn't read xserverrc)
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# Wayland login on tty2
[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec qtile start -b wayland

# Caged Firefox in Wayland on tty3
[[ -z $DISPLAY && $XDG_VTNR -eq 3 ]] && exec cage -d firefox
