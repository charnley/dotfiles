" Trying out neovim

" TODO https://github.com/albingroen/quick.nvim
" TODO https://github.com/junegunn/vim-easy-align " Easy align CSV data
" https://www.reddit.com/r/neovim/comments/pqnymo/the_lspsaga_hover_doc_command_not_working/

" set indentation tab
set autoindent
set expandtab
set indentexpr=O
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=0
set tabstop=4

set ignorecase " Case-insensitive searching
set lazyredraw " will buffer screen updates instead of updating all the time.:help 'ttyfast'
set list " Highlight unwanted spaces
set listchars=tab:▸\ ,trail:·
set mouse=a
set nohlsearch " I don't like to look at highlighted text
set noshowmode " insert is already showing in lightline
set noswapfile
set nowrap " Don't ever wordwrap my code
set number
set relativenumber
set scrolloff=8 " I like cursor to be in center
set sidescroll=1
set sidescrolloff=15
set signcolumn=yes:1 " always show sign column (bookmarks, gitgutter,..)
set smartcase " if a pattern contains an uppercase letter, it is case sensitive

" Leader
let mapleader=","

" Search open files
nnoremap <Leader>b :Buffers<cr>

" Search lines in current buffer
noremap <Leader>s :BLines<cr>

" Search all files registered with git
noremap <leader>f :GitFiles<CR>

" Search all files under current directory
noremap <leader>o :Files<CR>

" Switch between buffers
map bn :bnext<cr>
map bp :bprevious<cr>
map bd :bdelete<cr>

" Much like a browser, just tab between buffers
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" Copy to clipboard using ~/bin/yank
function! OscCopyVbuf()
  let executeCmd='yank ~/.vbuf'
  call system(executeCmd)
  mod " redraw the interface
endfunction

function! OscYank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
  mod " Redraw the interface
endfunction

command! OscCopyVbuf :call OscCopyVbuf()
noremap <silent> <Leader>y y:<C-U>call OscYank(@0)<CR>

" Copy the current visual slection to ~/.vbuf
vmap <S-y> :w! ~/.vbuf<CR>

" Copy the current line to the buffer file if no visual selection
nmap <S-y> :.w! ~/.vbuf<CR>

" Paste the contents of the buffer file
nmap <S-p> :r ~/.vbuf<CR>

" Delete without yank
nnoremap d "_d
vnoremap d "_d

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" User Interface
if has('cmdline_info')
  set ruler                   " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd                 " show partial commands in status line and
endif
set laststatus=2  " Always show the statusline
set cmdheight=1

" Fixes common typos
command W w
command Q q

" Ignore white space in diffmode
if &diff
    set diffopt+=iwhite
endif

" File types change
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

" Spelling
" add word: zg
" correct spelling: z=
set spelllang=en
set spellsuggest=best,10  " Show only the top ten candidates
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>

" Update buffer if file has changed
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
" vnoremap Y myY`y  " I use Y as cross-vim copy

call plug#begin()

    Plug 'MattesGroeger/vim-bookmarks'  " Easy bookmark shortcuts
    Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'sass', 'scss', 'stylus', 'vim'] }  " Preview CSS Colors
    Plug 'chaoren/vim-wordmotion' " Better word motion
    Plug 'easymotion/vim-easymotion'  " Jump to character
    Plug 'junegunn/fzf', { 'do': './install --all' } " Fuzzy find searching
    Plug 'junegunn/fzf.vim'  " Fuzzy find searching
    " Plug 'ldx/vim-indentfinder' " Auto ident
    Plug 'nanotech/jellybeans.vim'
    Plug 'tpope/vim-commentary' " For Commenting gcc & gc
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Better code syntax

    " Interface
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " IDE
    Plug 'windwp/nvim-autopairs'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'ray-x/lsp_signature.nvim'  " https://github.com/ray-x/lsp_signature.nvim

    Plug 'airblade/vim-gitgutter' " Git indication

call plug#end()

" TODO Need if colorscheme is there (for setup)
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
colorscheme jellybeans
highlight clear SignColumn  " fix bg color for SignColumn (for jellybeans)
highlight Pmenu ctermbg=none

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#tab_min_count = 2  " ignored : (
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline_powerline_fonts = 0
au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])

" Plug Bookmarks
" Add/remove bookmark at current line           mm  :BookmarkToggle
" Add/edit/remove annotation at current line    mi  :BookmarkAnnotate <TEXT>
" Jump to next bookmark in buffer               mn  :BookmarkNext
" Jump to previous bookmark in buffer           mp  :BookmarkPrev
" Show all bookmarks (toggle)                   ma  :BookmarkShowAll
" Clear bookmarks in current buffer only        mc  :BookmarkClear
" Clear bookmarks in all buffers                mx  :BookmarkClearAll
" Move up bookmark at current line              mkk     :BookmarkMoveUp
" Move down bookmark at current line            mjj     :BookmarkMoveDown
" Save all bookmarks to a file                  :BookmarkSave <FILE_PATH>
" Load bookmarks from a file                    :BookmarkLoad <FILE_PATH>
let g:bookmark_sign = '•'

" Git
let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '|'
let g:gitgutter_sign_modified_removed = '|'
highlight GitGutterAdd    ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red

" Undo block of git changes
nmap <leader>gu <Plug>(GitGutterUndoHunk)

" find next or prev git hunk
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)

" what changed in this hunk (close with :pclose)
nmap <leader>gh <Plug>(GitGutterPreviewHunk)
"au CursorMoved * if gitgutter#hunk#in_hunk(line(".")) | GitGutterPreviewHunk | else | pclose | endif

" Find char: f
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'qwertasdfgzxcv'
let g:EasyMotion_use_upper = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
nmap  f <Plug>(easymotion-s)
" xmap f <Plug>(easymotion-s)
" omap f <Plug>(easymotion-t)
" map J <Plug>(easymotion-j)
" map K <Plug>(easymotion-k)
hi link EasyMotionTarget Todo
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First Todo
hi link EasyMotionTarget2Second Todo
hi link EasyMotionIncSearch IncSearch
hi link EasyMotionIncCursor Search

" TODO Needs to re-evaluate
" >> Lsp key bindings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>

" Jump forward or backward in snippets
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Make VIM IDE like
lua << EOF
require'ide'
EOF

" On save. Would like to be on-demand, as each project has it's own per-commit rules
" source https://waylonwalker.com/vim-augroup/
" augroup waylonwalker
"     autocmd!
"     autocmd bufwritepre *.py execute 'PyPreSave'
"     autocmd bufwritepost *.py execute 'PyPostSave'
"     autocmd bufwritepost .tmux.conf execute ':!tmux source-file %' autocmd bufwritepost .tmux.local.conf execute ':!tmux source-file %'
"     autocmd bufwritepost *.vim execute ':source %'
" augroup end
