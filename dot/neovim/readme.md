# tl;dr changes to key bindings

## Basic extension of vim

| key | desc |
|---|---|
| ,d | Cut line(s) (old `dd`) |
| ,gb | Toggle git blame |
| ,gh | Git show changed |
| ,gn | Git find next hunk |
| ,gp | Git find previous hunk |
| ,gu | Git undo hunk |
| ,nf | Run format (`~/bin/format file`) |
| ,nw | Remove all trailing whitespaces |
| ,ob | Switch to open buffer |
| ,of | Open new file (:Files) |
| ,og | Open file (:GitFiles) |
| ,p | Toggle pastemode |
| ,y | Copy yank to clipboard (via OSC52) |
| ,z | Toggle spelling |
| Shift y | Copy to ~/.vbuf |
| Shify p | Paste fro ~/.vbuf |
| Tab | Goto next buffer |
| Tab+Shift | Goto previous buffer |
| bd | Delete current buffer |
| bn | Goto next buffer |
| bp | Goto previous buffer |
| f | Jump to character |

## IDE Like behavior

| key | desc |
|---|---|
| ,ld | lsp goto definition |
| ,ln | lsp rename variable |


TODO note on auto-complete and tab

## Write mode (Spelling and gramma)

TODO note on spelling

## Standard VIM

### Standard maps

| key | desc |
| % | goto matching bracket |
| gi | goto last insertion |
| gv | goto last visual selection |
| dit | delete inside tag (e.g. <div>inside</div>) |

### Live Replacement in NVIM 0.6

:%s/from/to/g

### Add star ending to all lines

    gg<Ctrl-v>G$A*<Esc>

## Very useful

Yank inside brackets any brackets and send to local clipboard when using tmux/vim via ssh

    # y(ank)
    # i(nside)
    # v (closets bracket)
    # ,y (leader y, send yank to ~/bin/yank)
    yiv,y

where osc52 (~/bin/yank) makes the local terminal put content in local clipboard.

## FAQ

- Why not format on buffer write? - Because when I collaborate with other there
  is new format rules for each git repository

## TODO

- TODO https://github.com/elianiva/dotfiles/tree/master/nvim/.config/nvim
- TODO https://github.com/junegunn/vim-easy-align " Easy align CSV data
- TODO Write mode rhysd/vim-grammarous
- TODO https://github.com/folke/zen-mode.nvim
- TODO https://github.com/mizlan/dotfiles/blob/master/.config/nvim/init.lua
- TODO https://github.com/romainl/vim-cool
