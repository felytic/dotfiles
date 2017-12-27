import os

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget

# Keys
ALT = 'mod1'
WIN = 'mod4'
TAB = 'Tab'
CTRL = 'control'
SHIFT = 'shift'
RETURN = 'Return'
SPACE = 'space'

keys = [
    # Switch between windows in current stack pane
    Key([WIN], 'k', lazy.layout.down()),
    Key([WIN], 'j', lazy.layout.up()),

    # Move windows up or down in current stack
    Key([WIN, CTRL], 'k', lazy.layout.shuffle_down()),
    Key([WIN, CTRL], 'j', lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([WIN], TAB, lazy.layout.next()),

    # Swap panes of split stack
    Key([WIN, SHIFT], SPACE, lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([WIN, SHIFT], RETURN, lazy.layout.toggle_split()),


    # Toggle between different layouts as defined below
    Key([WIN], SPACE, lazy.next_layout()),
    Key([WIN], 'w', lazy.window.kill()),

    Key([WIN, CTRL], 'r', lazy.restart()),
    Key([WIN, CTRL], 'q', lazy.shutdown()),
    Key([WIN], 'r', lazy.spawncmd()),

    # Volume control
    Key([WIN], 'Up', lazy.spawn('amixer set Master 5%+')),
    Key([WIN], 'Down', lazy.spawn('amixer set Master 5%-')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer set Master toggle')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer set Master 5%+')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer set Master 5%-')),

    # Brightness control
    Key([WIN], 'Right', lazy.spawn('xbacklight -inc 10')),
    Key([WIN], 'Left', lazy.spawn('xbacklight -dec 10')),

    # Applications hotkeys
    Key([WIN], RETURN, lazy.spawn('urxvt')),
    Key([WIN], 'g', lazy.spawn('google-chrome-stable')),
    Key([WIN], 'x', lazy.spawn('xfe')),

    # Lock screen
    Key([CTRL, ALT], 'l', lazy.spawn('slock')),
]

# ================================ GROUPS =====================================

groups = [Group(i) for i in '1234567890']

for i in groups:
    # win + letter of group = switch to group
    keys.append(
        Key([WIN], i.name, lazy.group[i.name].toscreen())
    )

    # win + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([WIN, SHIFT], i.name, lazy.window.togroup(i.name))
    )

# =============================================================================

layouts = [
    layout.Max(),
    layout.Matrix(num_stacks=4),
]

widget_defaults = dict(
    font='xos4 Terminess Powerline',
    fontsize=12,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    borderwidth=2,
                    rounded=False,
                    this_current_screen_border='7dbc2b',
                    use_mouse_wheel=False
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Systray(),
                widget.Sep(),
                widget.Volume(),
                widget.Sep(),
                widget.Battery(update_delay=5),
                widget.Sep(),
                widget.Clock(format=' %Y-%m-%d %a %H:%M:%S'),
            ],
            22,  # bar height
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([WIN], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([WIN], 'Button3', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([WIN], 'Button2', lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True
focus_on_window_activation = 'smart'
extentions = []
