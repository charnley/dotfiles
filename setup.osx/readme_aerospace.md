# AeroSpace Setup

[AeroSpace](https://github.com/nikitabobko/AeroSpace) is a modern i3-like tiling window manager for macOS. It replaces the yabai + skhd combination with a single binary and a single config file.

Config lives at: `~/.aerospace.toml` (symlink from `dot.osx/aerospace.toml`)

> **Note**: For the older yabai + skhd approach, see [readme_yabai.md](readme_yabai.md).

## 1. Install

```bash
brew install --cask nikitabobko/tap/aerospace
```

## 2. Grant Accessibility Permissions

The first time AeroSpace runs, macOS will prompt you to grant Accessibility permissions.

Go to: **System Preferences → Privacy & Security → Accessibility**

Add and enable AeroSpace.

## 3. Start AeroSpace

AeroSpace can be launched from Spotlight or set to start at login via its menu bar icon. It does not run as a `brew service`.

## 4. Configure Desktop Switching

AeroSpace manages workspaces natively — no need to create Spaces in Mission Control or set keyboard shortcuts there. Workspace switching is handled entirely in `~/.aerospace.toml`.

### Fix Desktop Auto-Reordering

Go to: **System Preferences → Mission Control**

- **Uncheck**: "Automatically rearrange Spaces based on most recent use"

---

## Keybindings

The config at `dot.osx/aerospace.toml` mirrors i3wm keybindings as closely as possible.

### Focus

| Key | Action |
|-----|--------|
| <kbd>Cmd</kbd> + <kbd>←</kbd> | Focus window left (wraps) |
| <kbd>Cmd</kbd> + <kbd>↓</kbd> | Focus window down (wraps) |
| <kbd>Cmd</kbd> + <kbd>↑</kbd> | Focus window up (wraps) |
| <kbd>Cmd</kbd> + <kbd>→</kbd> | Focus window right (wraps) |

### Move Windows

| Key | Action |
|-----|--------|
| <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd> | Move window left |
| <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>↓</kbd> | Move window down |
| <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>↑</kbd> | Move window up |
| <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>→</kbd> | Move window right |

### Workspaces

| Key | Action |
|-----|--------|
| <kbd>Cmd</kbd> + <kbd>1</kbd>–<kbd>9</kbd>, <kbd>0</kbd> | Switch to workspace 1–10 |
| <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>1</kbd>–<kbd>9</kbd>, <kbd>0</kbd> | Move window to workspace 1–10 |

### Layouts

| Key | Action |
|-----|--------|
| <kbd>Alt</kbd> + <kbd>H</kbd> | Split horizontal |
| <kbd>Alt</kbd> + <kbd>V</kbd> | Split vertical |
| <kbd>Alt</kbd> + <kbd>F</kbd> | Fullscreen |
| <kbd>Alt</kbd> + <kbd>S</kbd> | Stacking layout (v_accordion) |
| <kbd>Alt</kbd> + <kbd>T</kbd> | Tabbed layout (h_accordion) |
| <kbd>Alt</kbd> + <kbd>E</kbd> | Toggle tiling direction |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>Space</kbd> | Toggle floating/tiling |

### Other

| Key | Action |
|-----|--------|
| <kbd>Cmd</kbd> + <kbd>Enter</kbd> | Open Alacritty |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> | Reload config |
| <kbd>Alt</kbd> + <kbd>R</kbd> | Enter resize mode |

### Resize Mode

While in resize mode (<kbd>Alt</kbd> + <kbd>R</kbd>):

| Key | Action |
|-----|--------|
| <kbd>←</kbd> | Decrease width |
| <kbd>→</kbd> | Increase width |
| <kbd>↑</kbd> | Decrease height |
| <kbd>↓</kbd> | Increase height |
| <kbd>Enter</kbd> / <kbd>Esc</kbd> | Exit resize mode |

---

## Notable Config Choices

- **`cmd-h` overridden**: macOS uses <kbd>Cmd</kbd> + <kbd>H</kbd> to hide windows. AeroSpace intercepts it with a no-op so windows don't vanish unexpectedly.
- **Normalizations disabled**: `enable-normalization-flatten-containers` and `enable-normalization-opposite-orientation-for-nested-containers` are both `false` to match i3's behaviour. Re-enabling them is recommended once you're comfortable with AeroSpace's tree model.
- **Mouse follows focus**: When the focused monitor changes, the mouse moves to the center of that monitor (`move-mouse monitor-lazy-center`).
- **Persistent workspaces**: Set to `[]` (empty) — workspaces are created on demand, like in i3.

---

## Troubleshooting

### AeroSpace not working after macOS update

macOS updates can reset Accessibility permissions. Re-grant them:

**Go to: System Preferences → Privacy & Security → Accessibility**

Remove and re-add AeroSpace, then relaunch it.

### Keybindings not responding

Run `Alt` + `Shift` + `C` to reload the config, or relaunch AeroSpace from the menu bar icon.
