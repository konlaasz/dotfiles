#
# ~/.xinitrc: client init script used by xinit(1)
#
# vim: ft=sh:ts=4:sw=4:sts=4

# WM
DEFAULTWM=qtile

# WM-independent preloaded processes
# battery icon
#cbatticon -u 17 -i symbolic -c "systemctl suspend" -l 15 -r 6 &
cbatticon -u 17 -i standard -c "systemctl suspend" -l 15 -r 6 &
# audio
systemctl --user start pulseaudio.service &
# volume icon
pa-applet --disable-notifications &
# x settings
xrdb -merge ~/.Xresources
# Set xkb layout
#setxkbmap -layout 'us,dk,hu(qwerty)' -option 'grp:alt_shift_toggle'
#setxkbmap -layout 'ro,hu(qwerty),de(qwerty),dk' -option 'grp:alt_shift_toggle'
# per-window keyboard layout switching
#kbdd &
gxkb &>/dev/null &
# turn Caps Lock into Esc
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
# autorepeat for faster navigation
#xset r rate 300 50 &
# keyboard navigation
keynav daemonize &
# aggressive screen blanking
xset s 180 &
#xset dpms 0 0 120
# blue light filter
redshift &
# disable the touchpad when typing
#syndaemon &
# check package updates
#chuck &>/dev/null &

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
    quarkwm)
        exec qinit ;;
    qtile)
        exec qtile start ;;
    subtle)
        exec subtle ;;
esac

# been there, done that
# >>> the good:
# awesome, dwm, evilwm, fluxbox, icewm, jwm, wmii, xmonad
# >>> the bad:
# aewm, openbox, subtle, w9wm, yeahwm
# >>> the ugly:
# enlightenment, twindy, echinus
