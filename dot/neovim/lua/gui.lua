-- settings related to interface

vim.opt.ruler=true -- show the ruler
vim.opt.rulerformat=[[=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)]]
vim.opt.showcmd=true
vim.opt.laststatus=2
vim.opt.cmdheight=1

-- Set colorscheme to jellybeans
vim.api.nvim_exec([[
let g:jellybeans_overrides = {'background': { 'ctermbg': 'none', '256ctermbg': 'none' },}
try
    colorscheme jellybeans
catch /^Vim\%((\a\+)\)\=:E185/
    " Probably first installation
endtry

highlight clear SignColumn  " fix bg color for SignColumn (for jellybeans)
highlight Pmenu ctermbg=none
]], false)

-- fzf visual
vim.api.nvim_exec([[
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
]], false)

-- Airline theme
vim.api.nvim_exec([[
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#tab_min_count = 2  " ignored : (
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline_powerline_fonts = 0
au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])
]], false)


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

