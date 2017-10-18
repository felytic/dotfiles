from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget

mod = 'mod4'

keys = [
    # Switch between windows in current stack pane
    Key([mod], 'k', lazy.layout.down()),
    Key([mod], 'j', lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, 'control'], 'k', lazy.layout.shuffle_down()),
    Key([mod, 'control'], 'j', lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], 'Tab', lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, 'shift'], 'space', lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, 'shift'], 'Return', lazy.layout.toggle_split()),


    # Toggle between different layouts as defined below
    Key([mod], 'space', lazy.next_layout()),
    Key([mod], 'w', lazy.window.kill()),

    Key([mod, 'control'], 'r', lazy.restart()),
    Key([mod, 'control'], 'q', lazy.shutdown()),
    Key([mod], 'r', lazy.spawncmd()),

    Key([], 'XF86AudioRaiseVolume',
        lazy.spawn('amixer -c 1 -q set Master 2dB+')),
    Key([], 'XF86AudioLowerVolume',
        lazy.spawn('amixer -c 1 -q set Master 2dB-')),
    Key([], 'XF86AudioMute',
        lazy.spawn('amixer -c 1 -q set Master toggle')),

    Key([], 'XF86MonBrightnessUp',
        lazy.spawn('xbacklight -inc 10')),
    Key([], 'XF86MonBrightnessDown',
        lazy.spawn('xbacklight -dec 10')),

    Key([mod], 'Return', lazy.spawn('urxvt')),
    Key([mod], 'g', lazy.spawn('google-chrome-stable')),
    Key([mod], 'p', lazy.spawn('gpmdp')),
    Key([mod], 't', lazy.spawn('telegram-desktop')),
    Key([mod], 'x', lazy.spawn('xfe')),
]

groups = [Group(i) for i in '123456789']

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, 'shift'], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2)
]

widget_defaults = dict(
    font='xos4 Terminess Powerline',
    fontsize=12,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(borderwidth=2, rounded=False),
                widget.Prompt(),
                widget.WindowName(),
                widget.Systray(),
                widget.Sep(),
                widget.Volume(device='hw:1'),
                widget.Sep(),
                widget.Battery(update_delay=5),
                widget.Sep(),
                widget.Clock(format=' %Y-%m-%d %a %H:%M'),
            ],
            22,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front())
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
