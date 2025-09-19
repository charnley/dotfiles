
# Ubuntu / Debian setup notes

## Bluetooth

Bluetooth on blueman-applet is a bit buggy at times.
Especially when it auto-connectes/pairs.

so in the following conf, find the ReconnectAttempts and disable it.

    # /etc/bluetooth/main.conf
    ReconnectAttempts=0
