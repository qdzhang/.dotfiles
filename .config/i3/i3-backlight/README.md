i3-backlight
=========
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)][license]

Backlight control and volume for [i3wm]

## Installation

#### Requirements
* [i3wm]
* [xbacklight]

#### Optional
* [notify-osd], [dunst], or any [libnotify] compatible notification daemon
* `notify-send` (provided by [libnotify]) or `dunstify` (provided by [dunst])

#### Arch Linux
To be uploaded to the AUR

#### Notifications
Notifications are provided by [libnotify]. Any [libnotify] compatible notification daemon can be used for notifications. The most common are [notify-osd] and [dunst].

If you are using [dunst], you may optionally choose to use `dunstify` instead of `notify-send` by adding the `-y` option.

Expiration time of notifications can be changed using the `-e <time_in_milliseconds>` option. Default is 1500 ms. (Ubuntu's Notify OSD and GNOME Shell both ignore the expiration parameter.)

### Guide
Clone this repository: `git clone https://github.com/fmorisan/i3-backlight.git ~/i3-backlight`

Append the contents of the sample configuration file `i3-backlight.conf` to your i3 config, such as `~/.config/i3/config`

Reload i3 configuration by pressing `mod+Shift+r`

## Usage
Use your keyboard backlight keys to manage (increase or decrease) your backlight level. If you have a brightness indicator in your status line it will be updated to reflect the volume change. When notifications are enabled a popup will display the brightness level.

Example of notifications using [notify-osd]:

![Brightness Notification](https://github.com/fmorisan/i3-backlight/blob/master/dunst-notification.png)

## Common Issues
`Note` only one notification daemon can be running at the same time. [dunst] can't be running for notifications to go through [notify-osd] and vice-versa.  
If anything comes up drop an issue in this repo and we can figure it out. :)

## License
`i3-backlight` is released under [GNU General Public License v2][license]

Copyright (C) 1989, 1991 Free Software Foundation, Inc.

[dunst]: https://dunst-project.org
[i3wm]: https://i3wm.org
[libnotify]: https://developer.gnome.org/libnotify
[license]: https://www.gnu.org/licenses/gpl-2.0.en.html
[notify-osd]: https://launchpad.net/notify-osd
