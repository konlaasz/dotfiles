#
# ~/.zprofile
#
# vim:ft=sh:ts=4:sw=4:sts=4:et

# X login on tty1 (using startx - xinit doesn't read xserverrc)
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# Wayland login on tty2
#[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec cage -d firefox
[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec qtile start -b wayland
