# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"

if qtile.core.name == "x11":
    terminal = "urxvt"
elif qtile.core.name == "wayland":
    terminal = "kitty"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Tab", lazy.group.focus_back(),
        desc="Move focus to last window"),

    Key([mod], 'Escape', lazy.screen.toggle_group()),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move window up"),

    Key([mod, "mod1"], "h", lazy.layout.flip_left()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    Key([mod, "mod1"], "k", lazy.layout.flip_up()),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),
        desc="Grow window up"),

    Key([mod], 'comma', lazy.screen.prev_group(skip_managed=True, ),
        desc="Move focus to the previous group"),
    Key([mod], 'period', lazy.screen.next_group(skip_managed=True, ),
        desc="Move focus to the next group"),
    Key([mod], 'Left', lazy.screen.prev_group(skip_managed=True, ),
        desc="Move focus to the previous group"),
    Key([mod], 'Right', lazy.screen.next_group(skip_managed=True, ),
        desc="Move focus to the next group"),

    Key([mod], "n", lazy.layout.normalize(),
        desc="Reset all window sizes"),

    Key([mod], 'f', lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], 'f', lazy.window.toggle_floating()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),

    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    Key([mod], 's', lazy.spawn('slock')),

#    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),
#    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
#    Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),

    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5")),

    Key([mod], 'z', lazy.spawn('cmus-remote --prev')),
    Key([mod], 'x', lazy.spawn('cmus-remote --play')),
    Key([mod], 'c', lazy.spawn('cmus-remote --pause')),
    Key([mod], 'v', lazy.spawn('cmus-remote --stop')),
    Key([mod], 'b', lazy.spawn('cmus-remote --next')),
]

groups = [
    Group('α',
        layout="bsp",
    ),
    Group("β",
        matches=[Match(wm_class=["firefox"])],
    ),
    Group('γ',
        matches=[Match(wm_class=["calibre", "RockboxUtility"])],
    ),
    Group('δ',
    ),
]

for index, grp in enumerate(groups):
     # index is the position in the group list, grp is the group object.
     # We assign each group object a set of keys based on its
     # position in the list.
     keys.extend([
             # mod1 + number of group = switch to group
         Key([mod], str(index+1), lazy.group[grp.name].toscreen()),
             # mod1 + control + number of group = move focused window to group
         Key([mod, "control"], str(index+1), lazy.window.togroup(grp.name)),
             # mod1 + shift + number of group = switch to & move
             # focused window to group
         Key([mod, "shift"], str(index+1), lazy.window.togroup(grp.name,
             switch_group=True)),
    ])

layouts = [
    layout.Max(),
    layout.Bsp(
        border_normal="#3f3f3f",
        border_focus="#8f8f8f",
        border_width=1,
        fair=True,
        grow_amount=6,
        lower_right=True,
        margin=0,
        ratio=2.1,
    ),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    border_width=2,
                    active="#c3bf9f",
                    inactive="#8f8f8f",
                    highlight_color=['#3f3f3f', '#c3bf9f'],
                    highlight_method="block",
                    this_current_screen_border='#3a3a3a',
                    urgent_border='#cf8383',
                    urgent_text='#3a3a3a',
                    margin=2,
                    spacing=2,
                ),
                widget.CurrentLayoutIcon(scale=.8),
                widget.Prompt(ignore_dups_history=True),
                widget.WindowName(),
#                widget.KeyboardLayout(
#                    configured_keyboards=['us', 'dk', 'hu qwerty'],
#                    display_map={'us': 'us', 'dk': 'dk', 'hu qwerty': 'hu'}
#                ),
                widget.Cmus(
                    play_color="#8f8f8f",
                    noplay_color="#3a3a3a"
                ),
                widget.Systray(),
                widget.Clock(format='%y.%m.%d %V.%u %H:%M'),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='mpv'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
