-- settings related to interface

vim.opt.ruler = true -- show the ruler
vim.opt.rulerformat = [[=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)]]
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.cmdheight = 1

require("kanagawa").setup({
  compile = false, -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = {},
  keywordStyle = { italic = false },
  statementStyle = { bold = false },
  typeStyle = {},
  transparent = true, -- do not set background color
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = { -- add/modify theme and palette colors
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {
      ui = { bg_gutter = "none" },
    } },
  },
  overrides = function(colors) -- add/modify highlights
    local palette = colors.palette
    return {
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },
      GitGutterAdd = { fg = palette.springGreen },
      GitGutterChange = { fg = palette.carpYellow },
      GitGutterDelete = { fg = palette.peachRed },
    }
  end,
  background = {
    dark = "wave",
    light = "lotus",
  },
})

vim.cmd("colorscheme kanagawa-wave")

-- fzf visual
vim.env.FZF_DEFAULT_OPTS = "--reverse"
vim.g.fzf_layout = { window = { width = 0.8, height = 0.8 } }

require("hardline").setup({
  bufferline = true, -- disable bufferline
  bufferline_settings = {
    exclude_terminal = false, -- don't show terminal buffers in bufferline
    show_index = false, -- show buffer indexes (not the actual buffer numbers) in bufferline
  },
  theme = "default", -- change theme
  sections = { -- define sections
    { class = "mode", item = require("hardline.parts.mode").get_item },
    { class = "high", item = require("hardline.parts.git").get_item, hide = 100 },
    { class = "med", item = require("hardline.parts.filename").get_item },
    "%<",
    { class = "med", item = "%=" },
    { class = "low", item = require("hardline.parts.wordcount").get_item, hide = 100 },
    { class = "error", item = require("hardline.parts.lsp").get_error },
    { class = "warning", item = require("hardline.parts.lsp").get_warning },
    { class = "warning", item = require("hardline.parts.whitespace").get_item },
    { class = "high", item = require("hardline.parts.filetype").get_item, hide = 60 },
    { class = "mode", item = require("hardline.parts.line").get_item },
  },
})

-- bookmark
vim.g.bookmark_sign = "•"

-- Git gutter signs
vim.g.gitgutter_sign_added = "|"
vim.g.gitgutter_sign_modified = "|"
vim.g.gitgutter_sign_removed = "|"
vim.g.gitgutter_sign_modified_removed = "|"
-- Gutter highlight colors (cterm fallback for terminals without true color)
vim.api.nvim_set_hl(0, "GitGutterAdd", { ctermfg = "green" })
vim.api.nvim_set_hl(0, "GitGutterChange", { ctermfg = "yellow" })
vim.api.nvim_set_hl(0, "GitGutterDelete", { ctermfg = "red" })
