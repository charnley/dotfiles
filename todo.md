
# Dotfiles todo

## Mac OSX

- [ ] Explore https://github.com/nikitabobko/AeroSpace & https://github.com/omerxx/dotfiles


    Deprecated Neovim Plugin (dot/neovim/lua/plugins.lua:21)
    - kabouzeid/nvim-lspinstall is deprecated/archived
    - Consider using williamboman/mason.nvim + williamboman/mason-lspconfig.nvim
    instead


    Duplicate Alacritty configs (dot/alacritty/)
    - Both alacritty.yml and alacritty.toml exist
    - Alacritty has migrated to TOML; the YAML file is likely deprecated

    Lua syntax issue (dot/neovim/lua/base.lua:14)
    - vim.opt.indentexpr = O - O is an undefined variable (should likely be "" or removed)

    Refactoring plugin not installed (dot/neovim/lua/ide.lua:276-300)
    - Uses require("refactoring") but the plugin isn't in plugins.lua
