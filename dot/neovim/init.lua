local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("base") -- Standard VIM settings
require("plugins") -- Install all plugins
require("maps") -- Most key mappings

-- Check if vim is being installed for the first time
local is_not_setup = vim.env.NEOVIM_SETUP

if is_not_setup == nil then
  require("gui") -- Everything related to visual
  require("ide")
end
