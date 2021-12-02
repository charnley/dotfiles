" Trying out neovim
"
" TODO coc + snippet setup
"
"Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'sass', 'scss', 'stylus', 'vim'] }
"Plug 'alvan/vim-closetag'
"Plug 'MattesGroeger/vim-bookmarks'
"Plug 'gmarik/vundle'
"Plug 'majutsushi/tagbar'
"" Plug 'ervandew/supertab'
"" Plug 'vim-syntastic/syntastic'
"Plug 'w0rp/ale'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"" Plug 'vim-scripts/CSApprox'
"" Plug 'dracula/vim'
"" Plug 'nanotech/jellybeans.vim'
"Plug 'flazz/vim-colorschemes'
"Plug 'nanotech/jellybeans.vim'
"Plug 'tomasiser/vim-code-dark'
"Plug 'vim-scripts/L9'
"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
"Plug 'tomtom/tcomment_vim'
"Plug 'easymotion/vim-easymotion'
"Plug 'junegunn/fzf', { 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
"Plug 'itchyny/lightline.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'tpope/vim-obsession'
"Plug 'junegunn/goyo.vim'
"Plug 'ldx/vim-indentfinder'
"Plug 'chaoren/vim-wordmotion'
"

:set autoindent
:set mouse=a
:set number
:set relativenumber
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set tabstop=4
:set wrap!
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

set ttyfast
set lazyredraw

" Leader
let mapleader=","

" Search open files
nnoremap <Leader>b :Buffers<cr>

" Search lines in current buffer
noremap <Leader>s :BLines<cr>

" Open new file
" :FZF searches all files
" GitFiles searches git-files
noremap <leader>f :GitFiles<CR>

" Copy to clipboard using ~/bin/yank
function! OscCopyVbuf()
  let executeCmd='yank ~/.vbuf'
  call system(executeCmd)
  redraw!
endfunction
function! OscYank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
command! OscCopyVbuf :call OscCopyVbuf()
noremap <silent> <Leader>y y:<C-U>call OscYank(@0)<CR>

" Copy the current visual slection to ~/.vbuf
vmap <S-y> :w! ~/.vbuf<CR>
" Copy the current line to the buffer file if no visual selection
nmap <S-y> :.w! ~/.vbuf<CR>
" Paste the contents of the buffer file
nmap <S-p> :r ~/.vbuf<CR>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" User Interface
if has('cmdline_info')
  set ruler                   " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd                 " show partial commands in status line and
endif
set laststatus=2  " Always show the statusline
set cmdheight=1

" Shortcuts for Home/end because my home/end is position
" crap on my thinkpad
" Ctrl+Shift+Left/Right -> Home/End
nnoremap <C-S-Left> <Home>
inoremap <C-S-Left> <Home>
nnoremap <C-S-Right> <End>
inoremap <C-S-Right> <End>

" Fixes common typos
command W w
command Q q

" vimdiff
if &diff
    " ignore whitespace in diffmode
    set diffopt+=iwhite
endif

" Filetypes change
au BufRead,BufNewFile *.md,*.mdx,*.markdown :set filetype=markdown
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


call plug#begin()

Plug 'MattesGroeger/vim-bookmarks'  " Easy bookmark shortcuts
Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'sass', 'scss', 'stylus', 'vim'] }  " Preview CSS Colors
Plug 'chaoren/vim-wordmotion' " Better word motion
Plug 'easymotion/vim-easymotion'  " Jump to character
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': './install --all' } " Fuzzy find searching
Plug 'junegunn/fzf.vim'  " Fuzzy find searching
Plug 'ldx/vim-indentfinder' " Auto ident
Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'ryanoasis/vim-devicons' " Developer Icons
Plug 'tpope/vim-commentary' " For Commenting gcc & gc


" IDE
" Plug 'nathanaelkane/vim-indent-guides' " Indentation lines  usage: <leader>ig
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting
set wildignore+=*/node_modules/**

" Git
" Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

:colorscheme jellybeans
highlight clear SignColumn  " fix bg color for SignColumn (for jellybeans)


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
let g:bookmark_sign = '♥'

" Git
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" Undo block of git changes
nmap <leader>gu <Plug>(GitGutterUndoHunk)
" find next or prev git hunk
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)
" what changed in this hunk (close with :pclose)
nmap <leader>gh <Plug>(GitGutterPreviewHunk)
"au CursorMoved * if gitgutter#hunk#in_hunk(line(".")) | GitGutterPreviewHunk | else | pclose | endif


" Find char f
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'qwertasdfgzxcv'
let g:EasyMotion_use_upper = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
map  f <Plug>(easymotion-s)
xmap f <Plug>(easymotion-s)
omap f <Plug>(easymotion-t)
map J <Plug>(easymotion-j)
map K <Plug>(easymotion-k)
hi link EasyMotionTarget Todo
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First Todo
hi link EasyMotionTarget2Second Todo
hi link EasyMotionIncSearch IncSearch
hi link EasyMotionIncCursor Search

" Interface
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'component': {
	\   'readonly': '%{&readonly?"x":""}',
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
	\ }
