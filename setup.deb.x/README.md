# Ubuntu 22.04 LTS

## Bluetooth Headet

There is still problem with getting Bluetooth headset works out of the box https://askubuntu.com/questions/1029242/bluetooth-speaker-doesnt-pair-in-ubuntu-16-04

Edit /etc/pulse/default.pa and comment out (with a #)

    #load-module module-bluetooth-discover

Then edit /usr/bin/start-pulseaudio-x11 and add the module load after the following line

    # Find this line
    if [ x”$SESSION_MANAGER” != x ] ; then /usr/bin/pactl load-module module-x11-xsmp “display=$DISPLAY session_manager=$SESSION_MANAGER” > /dev/null fi
    # Add this line
    /usr/bin/pactl load-module module-bluetooth-discover

Then the bluetooth discover module is loaded after x11 is started. Then you can use `blueman-applet` to connect, and the sound should be visible in `pavucontrol`.

## Bluetooth re-connects

Bluetooth on blueman-applet is a bit buggy at times.
Especially when it auto-connectes/pairs.

so in the following conf, find the ReconnectAttempts and disable it.

    # /etc/bluetooth/main.conf
    ReconnectAttempts=0

## USB sound not showing up in `pavucontrol`

In my case, the card was shown in `pactl` sink list, but not showing up in `pavucontrol`/pulseaudio

Find the card id in

    aplay -l | grep card

then add it to `/etc/pulse/default.pa` like this

    load-module module-alsa-sink device=hw:0

where `0` is the card id found before.

## References

- https://askubuntu.com/questions/687062/usb-audio-interface-not-showing-device-in-list-for-pulseaudio
