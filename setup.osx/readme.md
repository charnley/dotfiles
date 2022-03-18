
# Mac OSX

So you want to have a Debian i3wm-like workflow on mac? Too bad.
Well, this is as close you will get. First to do anything you'll need brew and standard GNU tools.
And before that you'll need to setup xcode.

    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

with xcode and brew setup, we can then install all the standard tools you are use too.
I Manage all my brew packages in a Brewfile located in `lists`.

    brew bundle --file ./lists/gnu.Brewfile  # install all expected terminal tools

## Window manager and i3-like setup

    brew bundle --file ./lists/i3like.Brewfile  # install window manager, and terminal to make it feel like i3wm

Yabai is the window manager, and skhd is the shortcut manager.

Then start the services. When starting each service the first time you will be prompted by Mac to add the service in

    System Preferences -> Security & Privacy -> Accessbility

Please check of each service when prompted

    brew services start yabai
    brew services start skhd

Some shortcuts are not manageable with skhd. Let's setup Desktop switching. First create all 10 Desktops. Press Ctrl - Up and find the "+" on the right side. Add until you have 1-9 Desktops. Then to fix shortcuts goto

    System Preferences -> Keyboard -> Shortcuts -> Mission Control
    Select each "Switch to Desktop X" and change it to Cmd + X


## Extra Mac Settings

Change the default colour look for mac

    System Preferences -> General
    Set "Appearance" to "Dark"

Disable the animation when switching desktops and reduce transparency.

    System Preferences -> Accesibility -> Display
    Check "Reduce motion"
    Check "Reduce transparency"


The mac bar at the bottom is taking a lot of space. Let's remove it by default

    System Preferences -> Dock & Menu Bar
    Check "Automatically hide and show the Dock"
    Uncheck "Animate opening applications"
    Change "Size" to your liking


## Mac hardware

### Mouse

To change the direction of the mouse scroll

    System Preferences -> Mouse -> Scroll direction (uncheck)

### Keyboard

If you are like me, and never use Caps for anything, change it to Cmd (Super) for extra easy modifier
This needs to be done per-new external keyboard.

    System Preferences -> Keyboard -> Modifiers
    Select keyboard
    Change caps to command


### Mac shortcuts

The default keyboard shortcut for screenshot is pretty f*cked on mac. Change it.

    System Preferences -> Keyboard -> Shortcuts -> Screenshots
    Change "Save picture of selected area as a file"

My default is "Cmd + p". Uncheck the rest, as you probably use those shortcuts for other things.





### 



### Notes


prompt
   only show last folder
   fix git (master)
   show hostname, with color

remap capslock to alt (for main modifier)
    done via keyboard settings

how to jump "word"?

when I can jump desktop with skhd
  - remap control to sane

alt + enter: open iterm
alt + 1: jump to desktop 1

yabai
    float toggle shortcut
    reset layout, useful for when moving between docks/screen

disable ALL BELL
    turned down system bell

conda activate, hide when basic
 - something else when full path
 - zsh specific

keyboard fixes:
    - altgr is cmd on mac (could it be primary mod?)

nvim vs vim on mac?

vim
    movement shortcuts (end of line, home, word) needs to work!

fzf
    ignore mac paths
        Lib
        One Drive

iterm
    fix colorscheme

alt to
    pageup / pagedown / home / end 
        on mac keyboard

dont sleep on docked

pull-down termina
    cmd+shift+enter = open a tmp terminal for fast commands


tmux is not reloading session on mac

timer.py
    from terminal "set timer with note" fast



mac notes

    # Reduce workspace switch animation
    https://apple.stackexchange.com/questions/17929/how-can-i-disable-animation-when-switching-desktops-in-lion
