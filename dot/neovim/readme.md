# tl;dr changes to key bindings

## Basic extension of vim

| key | desc |
|---|---|
| ,b | Switch to open buffer |
| ,f | Jump to character |
| ,f | Open new buffer (git files) |
| ,gh | Git show changed |
| ,gn | Git find next hunk |
| ,gp | Git find previous hunk |
| ,gu | Git undo hunk |
| ,o | Open new buffer (all files) |
| ,y | Copy yank to clipboard (via OSC52) |
| Alt Left | Goto previous buffer |
| Alt Right | Goto next buffer |
| F11 | Enable spell control |
| F5 | Remove all trailing spaces |
| Shift y | Copy to ~/.vbuf |
| Shify p | Paste fro ~/.vbuf |
| bd | Delete current buffer |
| bn | Goto next buffer |
| bp | Goto previous buffer |

## IDE Like behavior

| key | desc |
|---|---|
| ,ld | lsp goto definition |
| ,ln | lsp rename variable |


TODO note on auto-complete and tab

## Write mode (Spelling and gramma)

TODO note on spelling

## Notes

Live Replacement in NVIM 0.6

    :%s/from/to/g

## Standard VIM bindings I forget

| key | desc |
| % | goto matching bracket |
| gi | goto last insertion |
| gv | goto last visual selection |
| dit | delete inside tag (e.g. <div>inside</div>) |
