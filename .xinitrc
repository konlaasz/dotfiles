#!/bin/sh
#
# ~/.xinitrc: client init script used by xinit(1)
#
# vim:ft=sh:ts=4:sw=4:sts=4:fdm=marker

WM=awesome

# Logging {{{
exec > ~/.xinit.log 2>&1
# }}}

# Sourced scripts and settings {{{
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for SCRIPT in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$SCRIPT" ] && . "$SCRIPT"
    done
    unset SCRIPT
fi

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
# }}}

# WM-independent preloaded processes {{{

# Audio {{{
# Pipewire
systemctl --user start pipewire-pulse.service &
# }}}

# Video {{{
# Blue light filter
redshift > /dev/null 2>&1 &
# Screen blanking
xset s 180 &
#xset dpms 0 0 120
# }}}

# Keyboard {{{
# Set xkb layout
setxkbmap -layout 'us,dk,hu(qwerty)' -option 'grp:alt_shift_toggle' &
# Per-window keyboard layout switching
gxkb > /dev/null 2>&1 &
#kbdd &
# Autorepeat for faster navigation
#xset r rate 300 50 &
# Keyboard navigation
keynav daemonize &
# Disable the touchpad when typing
#syndaemon &
# }}}

# Tray applets, etc. {{{
# urxvt daemon
#urxvtd -f -o -q &
# Volume applet
pa-applet --disable-notifications &
# battery icon
#cbatticon -u 17 -i standard -c "systemctl suspend" -l 15 -r 6 &
# check package updates
chuck > /dev/null 2>&1 &
# }}}

# }}}

# WM-specific preloaded processes and exec lines {{{
# exec lines need to be closed with ;;
case $WM in
    awesome)
        exec awesome ;;
    evilwm)
        xsetroot -cursor_name left_ptr &
        exec evilwm -term urxvt -snap 5 -nosoliddrag ;;
    herbstluftwm)
        exec herbstluftwm --locked ;;
    jwm)
        exec jwm ;;
    qtile)
        exec qtile start ;;
esac
# }}}
