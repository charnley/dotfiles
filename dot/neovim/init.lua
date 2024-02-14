
require 'plugins' -- Install all plugins
require 'base' -- Standard VIM settings
require 'maps' -- Most key mappings

-- Check if vim is being installed for the first time
local is_not_setup = vim.env.NEOVIM_SETUP

if is_not_setup == nil then
    require 'gui' -- Everything related to visual
    require 'ide'
end
