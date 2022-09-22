#
# ~/.zprofile: Executed for login shells
#
# vim:ft=zsh:ts=4:sw=4:sts=4:et

export PATH=$PATH:$HOME/.local/bin

export EDITOR=vim
export VISUAL=$EDITOR
export BROWSER=firefox

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"

export CHECKUPDATES_DB=$XDG_CACHE_HOME/checkupdates

# X login on tty1 (using startx - xinit doesn't read xserverrc)
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# Wayland login on tty2
[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec qtile start -b wayland
