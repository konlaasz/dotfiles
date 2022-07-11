#
# ~/.xinitrc: client init script used by xinit(1)
#
# vim:ft=sh:ts=4:sw=4:sts=4:fdm=marker

# WM
DEFAULTWM=awesome

# WM-independent preloaded processes

# Audio {{{
# Pipewire
systemctl --user start pipewire-pulse.service &
# }}}

# Video {{{
# Blue light filter
redshift &
# Screen blanking
xset s 180 &
#xset dpms 0 0 120
# }}}

# Keyboard {{{
# Set xkb layout
#setxkbmap -layout 'us,dk,hu(qwerty)' -option 'grp:alt_shift_toggle'
# Per-window keyboard layout switching
gxkb &>/dev/null &
#kbdd &
# Autorepeat for faster navigation
#xset r rate 300 50 &
# Turn Caps Lock into Esc
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
# Keyboard navigation
keynav daemonize &
# Disable the touchpad when typing
#syndaemon &
# }}}

# Xrdb {{{
# X settings
xrdb -merge ~/.Xresources
# }}}

# Tray icons, etc. {{{
# urxvt daemon
#urxvtd -f -o -q &
# Network Manager applet
nm-applet &
# Volume applet
pa-applet --disable-notifications &
# battery icon
#cbatticon -u 17 -i standard -c "systemctl suspend" -l 15 -r 6 &
# check package updates
chuck &>/dev/null &
# }}}

# use the WM specified as $1, falling back to DEFAULTWM if $1 is empty
WM=${1:-$DEFAULTWM}

# WM-specific preloaded processes and exec lines
# exec lines should be closed with ;;
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

# been there, done that
# >>> the good:
# awesome, dwm, evilwm, fluxbox, icewm, jwm, wmii, xmonad
# >>> the bad:
# aewm, openbox, subtle, w9wm, yeahwm
# >>> the ugly:
# enlightenment, twindy, echinus
