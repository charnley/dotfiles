-- settings related to interface

vim.opt.ruler=true -- show the ruler
vim.opt.rulerformat=[[=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)]]
vim.opt.showcmd=true
vim.opt.laststatus=2
vim.opt.cmdheight=1

-- -- Set colorscheme to jellybeans
-- vim.api.nvim_exec([[
-- let g:jellybeans_overrides = {'background': { 'ctermbg': 'none', '256ctermbg': 'none' },}
-- try
--     colorscheme jellybeans
-- catch /^Vim\%((\a\+)\)\=:E185/
--     " Probably first installation
-- endtry

-- highlight clear SignColumn  " fix bg color for SignColumn (for jellybeans)
-- highlight Pmenu ctermbg=none
-- ]], false)


require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = false },
    functionStyle = {},
    keywordStyle = { italic = false},
    statementStyle = { bold = false },
    typeStyle = {},
    transparent = true,         -- do not set background color
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {
        },
        theme = { wave = {}, lotus = {}, dragon = {}, all = {
ui = {bg_gutter = "none"}
} },
    },
    overrides = function(colors) -- add/modify highlights
        return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
        GitGutterAdd = {fg = "green"},
        GitGutterChange  = {fg="yellow"},
        GitGutterDelete = {fg = "red"},
        }
    end,
    background = {
        dark = "none",
        light = "none",
    },
})


vim.cmd("colorscheme kanagawa-wave")
-- vim.api.nvim_exec([[
-- colorscheme kanagawa-wave
-- ]], false)




-- fzf visual
vim.api.nvim_exec([[
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
]], false)

-- -- Airline theme
-- vim.api.nvim_exec([[
-- let g:airline#extensions#tabline#enabled = 1
-- let g:airline#extensions#tabline#formatter = 'unique_tail'
-- let g:airline#extensions#tabline#show_close_button = 0
-- let g:airline_skip_empty_sections = 1
-- let g:airline#extensions#tabline#tab_min_count = 2  " ignored : (
-- let g:airline#extensions#tabline#left_sep = ' '
-- let g:airline#extensions#tabline#left_alt_sep = ''
-- let g:airline#extensions#tabline#right_sep = ' '
-- let g:airline#extensions#tabline#right_alt_sep = ''
-- let g:airline_powerline_fonts = 0
-- au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])
-- ]], false)

require('hardline').setup {
  bufferline = true,  -- disable bufferline
  bufferline_settings = {
    exclude_terminal = false,  -- don't show terminal buffers in bufferline
    show_index = false,        -- show buffer indexes (not the actual buffer numbers) in bufferline
  },
  theme = 'default',   -- change theme
  sections = {         -- define sections
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'high', item = require('hardline.parts.git').get_item, hide = 100},
    {class = 'med', item = require('hardline.parts.filename').get_item},
    '%<',
    {class = 'med', item = '%='},
    {class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 100},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},
    {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  },
}

-- bookmark
vim.api.nvim_exec([[
let g:bookmark_sign = '•'
]], false)


--  Git
vim.api.nvim_exec([[
let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '|'
let g:gitgutter_sign_modified_removed = '|'
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
]], false)

