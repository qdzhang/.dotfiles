#!/usr/bin/env python3

import logging
import signal
from pathlib import Path

import psutil

from i3ipc import Event, Connection
from i3ipc import aio as i3ipc_aio

from i3pyblocks import Runner, types, utils, blocks
from i3pyblocks.blocks import (  # shell,
    datetime,
    inotify,
    i3ipc,
    ps,
    pulse,
)

# Configure logging, so we can have debug information available in
# ~/.i3pyblocks.log
# Use `logging.INFO` to reduce verbosity
logging.basicConfig(filename=Path.home() / ".i3pyblocks.log", level=logging.DEBUG)


# Helper to find partitions, filtering some that we don't want to show
# Will be used later on the DiskUsageBlock
def partitions(excludes=("/boot", "/nix/store")):
    partitions = psutil.disk_partitions()
    return [p for p in partitions if p.mountpoint not in excludes]


class GetEmacsScratchpad(blocks.Block):
    '''
    Show whether emacs is running in scratchpad
    '''
    def __init__(
        self,
        format: str = "{window_title:.81s}",
        colors = ["#ffffff", "#ff79c6"],
        **kwargs,
    ):
        super().__init__(**kwargs)
        self.format = format
        self.colors = colors

    async def update_title(self, connection, *_):
        marks = await connection.get_marks()
        show_text = "No emacs"
        color=self.colors[0]

        if "emacsscratchpad" in marks:
            show_text = "Ɛmacs"
            color=self.colors[1]

        self.update(
            self.ex_format(
                self.format,
                window_title=(show_text),
            ),
            color=color,
        )

    async def start(self) -> None:
        connection = i3ipc_aio.Connection(auto_reconnect=True)

        await connection.connect()

        connection.on(Event.WORKSPACE_FOCUS, self.update_title)
        connection.on(Event.WINDOW_CLOSE, self.update_title)
        connection.on(Event.WINDOW_TITLE, self.update_title)
        connection.on(Event.WINDOW_FOCUS, self.update_title)

        try:
            await self.update_title(connection)
            await connection.main()
        except Exception as e:
            self.exception(e)


async def main():
    # Create a Runner instance, so we can register the modules
    runner = Runner()

    # Dracula theme colors
    d_color_cyan = "#8be9fd"
    d_color_green = "#50fa7b"
    d_color_orange = "#ffb86c"
    d_color_pink  = "#ff79c6"
    d_color_purple = "#bd93f9"
    d_color_red = "#ff5555"
    d_color_yellow = "#f1fa8c"

    # Show the current i3 focused window title
    # Using `.format()` (https://pyformat.info/) to limit the number of
    # characters to 41
    await runner.register_block(i3ipc.WindowTitleBlock(format=" {window_title:.41s}"))
    # await runner.register_block(GetEmacsScratchpad(colors=[d_color_red,d_color_pink]))

    # Show the current network speed for either en* (ethernet) or wl* devices
    # Limiting the interface name to only 2 characters since it can get quite
    # verbose
    await runner.register_block(
        ps.NetworkSpeedBlock(
            format_up=" {interface:.2s}↑{upload}↓{download}",
            format_down="",
            interface_regex="en*|wl*",
            colors=
            {
                0: d_color_purple,
                1 * types.IECUnit.MiB: d_color_yellow,
                4 * types.IECUnit.MiB: d_color_red,
            }
        )
    )

    # For each partition found, add it to the Runner
    # Using `{{short_path}}` shows only the first letter of the path
    # i.e.: /mnt/backup -> /m/b
    # for partition in partitions():
    #     await runner.register_block(
    #         ps.DiskUsageBlock(
    #             format=" {short_path}: {free:.1f}GiB",
    #             path=partition.mountpoint,
    #         )
    #     )

    await runner.register_block(
            ps.VirtualMemoryBlock(
                format="M {icon}",
                colors = {
                    0: d_color_cyan,
                    75: d_color_yellow,
                    90: d_color_red,
                }))

    # Using custom icons to show the temperature visually
    # So when the temperature is above 75,  is shown, when it is above 50,
    #  is shown, etc
    # Needs Font Awesome 5 installed
    # await runner.register_block(
    #     ps.SensorsTemperaturesBlock(
    #         format="{icon} {current:.0f}°C",
    #         icons={
    #             0: "",
    #             25: "",
    #             50: "",
    #             75: "",
    #         },
    #     )
    # )

    await runner.register_block(
            ps.CpuPercentBlock(
                format = "C {icon}",
                colors = {
                    0: d_color_cyan,
                    75: d_color_yellow,
                    90: d_color_red,
                }))

    # Load only makes sense depending of the number of CPUs installed in
    # machine, so get the number of CPUs here and calculate the color mapping
    # dynamically
    # cpu_count = psutil.cpu_count()
    # await runner.register_block(
    #     ps.LoadAvgBlock(
    #         format=" {load1}",
    #         colors={
    #             0: types.Color.NEUTRAL,
    #             cpu_count / 2: types.Color.WARN,
    #             cpu_count: types.Color.URGENT,
    #         },
    #     ),
    # )

    await runner.register_block(
        ps.SensorsBatteryBlock(
            format_plugged=" {percent:.0f}%",
            format_unplugged="{icon} {percent:.0f}% {remaining_time}",
            format_unknown="{icon} {percent:.0f}%",
            icons={
                0: "",
                10: "",
                25: "",
                50: "",
                75: "",
            },
            colors={
                0: "000000",
                10: d_color_red,
                25: d_color_green,
            },
        )
    )

    # ToggleBlock works by running the command specified in `command_state`,
    # if it returns any text it will show `format_on`, otherwise `format_off`
    # is shown
    # When `format_on` is being shown, clicking on it runs `command_off`,
    # while when `format_off` is being shown, clicking on it runs `command_on`
    # We are using it below to simulate the popular Caffeine extension in
    # Gnome and macOS
    # await runner.register_block(
    #     shell.ToggleBlock(
    #         command_state="xset q | grep -Fo 'DPMS is Enabled'",
    #         command_on="xset s on +dpms",
    #         command_off="xset s off -dpms",
    #         format_on="  ",
    #         format_off="  ",
    #     )
    # )

    # This is equivalent to the example above, but using pure Python
    # await runner.register_block(
    #     x11.CaffeineBlock(
    #         format_on="  ",
    #         format_off="  ",
    #     )
    # )

    # KbddBlock uses D-Bus to get the keyboard layout information updates, so
    # it is very efficient (i.e.: there is no polling). But it needs `kbdd`
    # installed and running: https://github.com/qnikst/kbdd
    # Using mouse buttons or scroll here allows you to cycle between the layouts
    # By default the resulting string is very big (i.e.: 'English (US, intl.)'),
    # so we lowercase it using '!l' and truncate it to the first two letters
    # using ':.2s', resulting in `en`
    # You could also use '!u' to UPPERCASE it instead
    # await runner.register_block(
    #     dbus.KbddBlock(
    #         format=" {full_layout!l:.2s}",
    #     )
    # )

    # MediaPlayerBlock listen for updates in your player (in this case Spotify)
    # await runner.register_block(dbus.MediaPlayerBlock(player="spotify"))

    # In case of `kbdd` isn't available for you, here is a alternative using
    # ShellBlock and `xkblayout-state` program.  ShellBlock just show the output
    # of `command` (if it is empty this block is hidden)
    # `command_on_click` runs some command when the mouse click is captured,
    # in this case when the user scrolls up or down
    # await runner.register_block(
    #     shell.ShellBlock(
    #         command="xkblayout-state print %s",
    #         format=" {output}",
    #         command_on_click={
    #             types.MouseButton.SCROLL_UP: "xkblayout-state set +1",
    #             types.MouseButton.SCROLL_DOWN: "xkblayout-state set -1",
    #         },
    #     )
    # )

    # By default BacklightBlock showns a message "No backlight found" when
    # there is no backlight
    # We set to empty instead, so when no backlight is available (i.e.
    # desktop), we hide this block
    await runner.register_block(
        inotify.BacklightBlock(
            format=" {percent:.0f}%",
            format_no_backlight="",
            command_on_click={
                types.MouseButton.SCROLL_UP: "light -A 5%",
                types.MouseButton.SCROLL_DOWN: "light -U 5",
            },
        )
    )

    # `signals` allows us to send multiple signals that this block will
    # listen and do something
    # In this case, we can force update the module when the volume changes,
    # for example, by running:
    # $ pactl set-sink-volume @DEFAULT_SINK@ +5% && pkill -SIGUSR1 example.py
    await runner.register_block(
        pulse.PulseAudioBlock(
            format=" {volume:.0f}%",
            format_mute=" mute",
            color_mute= d_color_red,
            colors= {
                0: d_color_yellow,
                20: d_color_purple,
            },
        ),
        signals=(signal.SIGUSR1, signal.SIGUSR2),
    )

    # RequestsBlock do a HTTP request to an url. We are using it here to show
    # the current weather for location, using
    # https://github.com/chubin/wttr.in#one-line-output
    # For more complex requests, we can also pass a custom async function
    # `response_callback`, that receives the response of the HTTP request and
    # you can manipulate it the way you want
    # await runner.register_block(
    #     http.PollingRequestBlock(
    #         "https://wttr.in/?format=%c+%t",
    #         format_error="",
    #         sleep=60 * 60,
    #     ),
    # )

    # You can use Pango markup for more control over text formating, as the
    # example below shows
    # For a description of how you can customize, look:
    # https://developer.gnome.org/pango/stable/pango-Markup.html
    await runner.register_block(
        datetime.DateTimeBlock(
            format_time=utils.pango_markup("%a/%m/%d %H:%M", font_weight="light", color=d_color_orange),
            format_date=utils.pango_markup("%a/%m/%d %H:%M", font_weight="light", color=d_color_orange),
            default_state={"markup": types.MarkupText.PANGO},
        )
    )

    # Start the Runner instance
    await runner.start()


if __name__ == "__main__":
    # Start the i3pyblocks
    utils.asyncio_run(main())
