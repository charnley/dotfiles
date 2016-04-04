
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "/opt/bin" ] ; then
    PATH="/opt/bin:$PATH"
fi
if [ -d "/opt/sbin" ] ; then
    PATH="/opt/sbin:$PATH"
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.history
SAVEHIST=20000

