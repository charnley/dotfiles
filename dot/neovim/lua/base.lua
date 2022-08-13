-- Base vim settings

-- vim.o: behaves like :let &{option-name}
-- vim.go: behaves like :let &g:{option-name}
-- vim.bo: behaves like :let &l:{option-name} for buffer-local options
-- vim.wo: behaves like :let &l:{option-name} for window-local options

-- vim.opt: behaves like :set
-- vim.opt_global: behaves like :setglobal
-- vim.opt_local: behaves like :setlocal

vim.opt.autoindent=true
vim.opt.expandtab=true
vim.opt.indentexpr=O
vim.opt.shiftwidth=4
vim.opt.smartindent=true
vim.opt.smarttab=true
vim.opt.softtabstop=0
vim.opt.tabstop=4

vim.opt.ignorecase=true -- Case-insensitive searching
vim.opt.lazyredraw=true -- will buffer screen updates instead of updating all the time.:help 'ttyfast'
vim.opt.list=true -- Highlight unwanted spaces
vim.opt.listchars = {
    tab = '│·',
    trail = '·',
    -- eol = '↵',
}
vim.opt.mouse='a'
vim.opt.hlsearch=false -- I don't like to look at highlighted text
vim.opt.showmode=false -- insert is already showing in lightline
vim.opt.swapfile=false
vim.opt.wrap=false -- Don't ever wordwrap my code
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.scrolloff=8 -- I like cursor to be in center
vim.opt.sidescroll=1
vim.opt.sidescrolloff=15
vim.opt.signcolumn='yes:1' -- always show sign column (bookmarks, gitgutter,..)
vim.opt.smartcase=true -- if a pattern contains an uppercase letter, it is case sensitive

vim.opt.wildmode={'longest','list','full'}
vim.opt.wildignore={
    '*.pyc',
    '*_build/*',
    '**/coverage/*',
    '**/node_modules/*',
    '**/ios/*',
    '**/.git/*',
}

-- Buffer specific
_G._autocommands = {}
_G._autocommands.is_space_or_tab = function()
    -- Check space or tab format. If space, check space width and update buffer

    -- File is very large, just use the default.
    if vim.fn.getfsize(vim.fn.bufname("%")) > 25600 then
        return
    end

    local lines = vim.fn.getbufline(vim.fn.bufname("%"), 1, 250)
    local lines_tabs = vim.fn.filter(lines, 'v:val =~ "^\\t"')
    local lines_spaces = vim.fn.filter(lines, 'v:val =~ "^ "')

    if #lines_tabs > #lines_spaces then
        vim.opt_local.expandtab=false
    else
        vim.opt_local.expandtab=true
        if #lines_spaces > 0 then
            _G._autocommands.find_indent_width(lines_spaces)
        end
    end
end

_G._autocommands.find_indent_width = function(lines)
    -- Check the whitespace per-buffer and set tabwidth

    local line = lines[1]
    local whitespace = 0

    for i = 1, #line do
        if (string.sub(line, i, i) == " ") then
            whitespace = whitespace + 1
        else
            break
        end
    end

    vim.opt_local.shiftwidth = whitespace
    vim.opt_local.tabstop = whitespace

end

-- TODO Is there a lua interface for BufReadPost?
vim.api.nvim_exec([[
  autocmd BufReadPost * lua _autocommands.is_space_or_tab()
]], false)


-- Overwrite default behavior
vim.api.nvim_exec([[ command W w ]], false) -- common typo
vim.api.nvim_exec([[ command Q q ]], false) -- common typo

vim.api.nvim_exec([[

" More sane undo (undo breakpoints on char)
inoremap " "<c-g>u
inoremap ( (<c-g>u
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap [ [<c-g>u

" I feel like going back a word should be consistent with w
nnoremap W b
vnoremap W b

" Move marked text (Sorry Peter, I use arrow)
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==i
inoremap <C-k> <esc>:m .-2<CR>==i
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv
inoremap <A-Down> <esc>:m .+1<CR>==i
inoremap <A-Up> <esc>:m .-2<CR>==i
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==

" Delete without yank
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" Cut (Delete & Yank) enabled via leader
nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" keep me centered when jumping
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
" vnoremap Y myY`y  " I use Y as cross-vim copy

]], false)

-- Set default behavior for filetypes
vim.api.nvim_exec([[
au BufRead,BufNewFile *.md,*.mdx,*.markdown setfiletype markdown
au BufRead,BufNewFile Jenkinsfile,*.Jenkinsfile setfiletype groovy
au BufRead,BufNewFile *.src setfiletype fortran
let fortran_more_precise=1
let fortran_dialect = "f77"
let s:extfname = expand("%:e")
if s:extfname ==? "f90"
    let fortran_free_source=1
    unlet! fortran_fixed_source
else
    let fortran_fixed_source=1
    unlet! fortran_free_source
endif
]], false)


-- Disable filetype plugin (it overwrites tab/indentation settings)
vim.api.nvim_exec([[filetype plugin off]], false)

-- Spelling
vim.opt.spelllang="en"
vim.opt.spellsuggest="best,10" -- show only the top 10 candidates

vim.opt.autoread=true -- Update buffer if file has changed
vim.api.nvim_exec([[
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
]],false)

-- Useful commands
vim.api.nvim_exec([[
command -nargs=0 -range SortWords <line1>,<line2>call setline('.',join(sort(split(getline('.'),' ')),' '))
]],false)
