# Mac OSX Setup

So you want to have a Debian i3wm-like workflow on Mac? Too bad.
Well, this is as close as you'll get.

## Prerequisites

Before anything else, you'll need Xcode Command Line Tools and Homebrew (Mac's package manager).

### 1. Install Xcode Command Line Tools

```bash
xcode-select --install
```

This will prompt a dialog box - click "Install" and wait for it to complete.

### 2. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Follow the on-screen instructions. After installation, you may need to add Homebrew to your PATH (the installer will tell you how).

### 3. Install Standard GNU Tools

With Xcode and Homebrew set up, install the standard Linux/GNU tools you're used to. All brew packages are managed in Brewfiles located in the `lists/` directory.

```bash
brew bundle --file ./lists/gnu.Brewfile
```

This installs GNU versions of common tools (grep, sed, find, etc.)

## Window Manager and i3-like Setup

This setup uses three main tools:
- **Yabai**: Tiling window manager (like i3wm)
- **skhd**: Keyboard shortcut daemon (like i3's keybindings)
- **Alacritty**: Fast, GPU-accelerated terminal emulator

### 1. Install the i3-like Stack

First, prevent macOS from complaining about "unsafe applications":

```bash
export HOMEBREW_CASK_OPTS="--no-quarantine"
```

Then install everything:

```bash
brew bundle --file ./lists/i3like.Brewfile
```

### 2. Start the Services

Start Yabai and skhd:

```bash
brew services start yabai
brew services start skhd
```

**Important**: The first time you start each service, macOS will prompt you to grant permissions.

Go to: **System Preferences → Security & Privacy → Accessibility**

Check the box for each service when prompted (yabai and skhd).

### 3. Configure Desktop Switching

Some shortcuts aren't manageable with skhd, so we'll configure them in macOS settings.

#### Create Multiple Desktops (Spaces)

1. Press <kbd>Ctrl</kbd> + <kbd>Up</kbd> to open Mission Control
2. Click the **"+"** button in the top-right corner
3. Repeat until you have 9 desktops (labeled 1-9)

#### Set Keyboard Shortcuts

Go to: **System Preferences → Keyboard → Shortcuts → Mission Control**

For each "Switch to Desktop X" option:
- Check the box to enable it
- Click on the shortcut and press <kbd>Cmd</kbd> + <kbd>[number]</kbd>

Example: "Switch to Desktop 1" should be <kbd>Cmd</kbd> + <kbd>1</kbd>

#### Fix Desktop Auto-Reordering

macOS likes to rearrange your desktops based on usage. This is annoying for tiling workflows.

Go to: **System Preferences → Mission Control**

- **Uncheck**: "Automatically rearrange Spaces based on most recent use"
- **Check**: "Displays have separate Spaces" (required for Yabai to work properly)

**Additional tips**: See https://github.com/koekeishiya/yabai/wiki/Tips-and-tricks for more configuration options.

## Extra Mac Settings

### Appearance

Make macOS look better and feel snappier:

**Go to: System Preferences → General**
- Set "Appearance" to **Dark**

**Go to: System Preferences → Accessibility → Display**
- **Check**: "Reduce motion" (disables animations when switching desktops)
- **Check**: "Reduce transparency" (improves performance and readability)

### Dock

The Dock at the bottom takes up valuable screen space. Hide it by default:

**Go to: System Preferences → Dock & Menu Bar**
- **Check**: "Automatically hide and show the Dock"
- **Uncheck**: "Animate opening applications"
- Adjust **Size** to your preference (smaller is better for tiling workflows)

### Fix Home/End Key Behavior

By default on Mac, **Home** and **End** jump to the beginning/end of the entire document (not the line). This is annoying when editing code or documents.

Fix it by following this guide: https://damieng.com/blog/2015/04/24/make-home-end-keys-behave-like-windows-on-mac-os-x/

**TL;DR**: Create a key bindings file at `~/Library/KeyBindings/DefaultKeyBinding.dict` to make Home/End behave like they do on Linux/Windows.

## Hardware Configuration

### Mouse

If you're coming from Linux/Windows, Mac's "natural" scroll direction will feel backwards.

**Go to: System Preferences → Mouse**
- **Uncheck**: "Scroll direction: Natural"

Now scrolling down moves content down (like every other OS).

### Keyboard

#### Remap Caps Lock to Command

If you never use Caps Lock (and who does?), remap it to **Command** for an easier-to-reach modifier key.

**Go to: System Preferences → Keyboard → Modifier Keys**
1. Select your keyboard from the dropdown
2. Change **Caps Lock** to **Command**

**Note**: You'll need to do this for each external keyboard you connect.

#### Fix Screenshot Shortcuts

Mac's default screenshot shortcuts are unnecessarily complex and conflict with useful shortcuts.

**Go to: System Preferences → Keyboard → Shortcuts → Screenshots**

1. Find "Save picture of selected area as a file"
2. Change it to something simple like <kbd>Cmd</kbd> + <kbd>P</kbd> (or your preference)
3. Uncheck the other screenshot shortcuts you won't use

**Why?** The default is <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>4</kbd>, which is hard to press and you probably won't remember it.

## Menu Bar (Top Status Bar)

Clean up the menu bar to reduce clutter:

**Go to: System Preferences → Control Centre → Menu Bar Only**

Remove unnecessary items like:
- Siri
- Spotlight
- Day of the week from the clock

Keep only what you actually use (battery, Wi-Fi, volume, clock).

## Control Auto-Start Apps

Prevent unnecessary apps from launching at startup:

**Go to: System Preferences → General → Login Items**

Review the list and disable anything you don't need running at startup. This speeds up boot time and reduces background processes.

Furthermore, if during reboot/system update you see a lot of applications getting thrown in your face, you can disable it by

```bash
defaults write -g ApplePersistence -bool no
```

## Tips and Tricks

### Paste Without Formatting

When you copy formatted text (from a website, PDF, etc.) and want to paste it as plain text:

- **Default paste**: <kbd>Cmd</kbd> + <kbd>V</kbd> (keeps formatting)
- **Paste without format**: <kbd>Opt</kbd> + <kbd>Shift</kbd> + <kbd>Cmd</kbd> + <kbd>V</kbd> (plain text only)

This is incredibly useful when pasting code or text into documents.

### Command Not Found After Pipe?

If you're getting "command not found" errors after using pipes (`|`) in the terminal, see this explanation: https://superuser.com/questions/1012574/why-is-bash-reporting-command-not-found-in-some-cases-in-the-terminal-but-not

**TL;DR**: It's usually a PATH issue with how macOS handles shell initialization.

---

## TODO / Future Improvements

These are things I'm still working on or want to add:

- [ ] Pull-down terminal setup (<kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>Enter</kbd> for quick terminal access)

---

## Troubleshooting

### Yabai or skhd not working after macOS update

macOS updates sometimes reset permissions. Re-grant Accessibility permissions:

**Go to: System Preferences → Security & Privacy → Accessibility**

Remove and re-add Yabai and skhd.

### Desktop shortcuts not working

Make sure you've:
1. Created the desktops in Mission Control (<kbd>Ctrl</kbd> + <kbd>Up</kbd>)
2. Set the keyboard shortcuts (System Preferences → Keyboard → Shortcuts → Mission Control)
3. Disabled "Automatically rearrange Spaces" in Mission Control settings

### Homebrew command not found

After installing Homebrew, you may need to add it to your PATH. The installer provides instructions, but typically you need to add this to your `~/.zshrc` or `~/.bash_profile`:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"  # For Apple Silicon Macs
# OR
eval "$(/usr/local/bin/brew shellenv)"      # For Intel Macs
```

Then reload your shell: `source ~/.zshrc`
