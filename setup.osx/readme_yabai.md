# Yabai + skhd Setup

So you want to have a Debian i3wm-like workflow on Mac? Too bad.
Well, this is as close as you'll get.

This setup uses two main tools:
- **Yabai**: Tiling window manager (like i3wm)
- **skhd**: Keyboard shortcut daemon (like i3's keybindings)

> **Note**: This is the older approach. See [readme_aerospace.md](readme_aerospace.md) for the modern alternative that replaces both tools with a single binary.

## 1. Install the i3-like Stack

First, prevent macOS from complaining about "unsafe applications":

```bash
export HOMEBREW_CASK_OPTS="--no-quarantine"
```

Then install everything:

```bash
brew bundle --file ./lists/i3like.Brewfile
```

## 2. Start the Services

Start Yabai and skhd:

```bash
brew services start yabai
brew services start skhd
```

**Important**: The first time you start each service, macOS will prompt you to grant permissions.

Go to: **System Preferences → Security & Privacy → Accessibility**

Check the box for each service when prompted (yabai and skhd).

## 3. Configure Desktop Switching

Some shortcuts aren't manageable with skhd, so we'll configure them in macOS settings.

### Create Multiple Desktops (Spaces)

1. Press <kbd>Ctrl</kbd> + <kbd>Up</kbd> to open Mission Control
2. Click the **"+"** button in the top-right corner
3. Repeat until you have 9 desktops (labeled 1-9)

### Set Keyboard Shortcuts

Go to: **System Preferences → Keyboard → Shortcuts → Mission Control**

For each "Switch to Desktop X" option:
- Check the box to enable it
- Click on the shortcut and press <kbd>Cmd</kbd> + <kbd>[number]</kbd>

Example: "Switch to Desktop 1" should be <kbd>Cmd</kbd> + <kbd>1</kbd>

### Fix Desktop Auto-Reordering

macOS likes to rearrange your desktops based on usage. This is annoying for tiling workflows.

Go to: **System Preferences → Mission Control**

- **Uncheck**: "Automatically rearrange Spaces based on most recent use"
- **Check**: "Displays have separate Spaces" (required for Yabai to work properly)

**Additional tips**: See https://github.com/koekeishiya/yabai/wiki/Tips-and-tricks for more configuration options.

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
