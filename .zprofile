#
# ~/.zprofile: Executed for login shells
#
# vim:ft=zsh:ts=4:sw=4:sts=4:et

export PATH=$PATH:$HOME/.local/bin

export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR
export BROWSER=/usr/bin/firefox

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"

export CHECKUPDATES_DB=$XDG_CACHE_HOME/checkupdates

export MPC_FORMAT="[[%artist%: ]%title%]\n[%album%][ (%date%)]"

# niri @ tty1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec niri --session

# sway (Wayland) @ tty2
[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec sway

# Hyprland (Wayland) @ tty3
[[ -z $DISPLAY && $XDG_VTNR -eq 3 ]] && exec Hyprland

# qtile (Wayland) @ tty4
[[ -z $DISPLAY && $XDG_VTNR -eq 4 ]] && exec qtile start -b wayland

# awesome (X) @ tty5 (using startx - xinit doesn't read xserverrc)
[[ -z $DISPLAY && $XDG_VTNR -eq 5 ]] && exec startx

# cage @ tty6
[[ -z $DISPLAY && $XDG_VTNR -eq 6 ]] && exec cage -- OpenKiosk --kiosk
