
" ----------------------------------------
" VI Improved Configuration
" ----------------------------------------

" My Github repo for dot files
" https:/github.com/charnley/dotfiles

" Inspired by (copied from):
" https://github.com/mbrochh/vim-as-a-python-ide
" https://github.com/r00k/dotfiles

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


" ----------------------------------------
" Vundle
" ----------------------------------------

" Vundle is a bundle manager for VIM.
" Baiscly a must have!
" https://github.com/gmarik/vundle
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

filetype off

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

" let html tags be close automatic
Bundle 'alvan/vim-closetag'


" let Vundle manage Vundle
Bundle 'gmarik/vundle'


" Tagbar
Bundle 'majutsushi/tagbar'


" Supertab
" https://github.com/ervandew/supertab
Bundle 'ervandew/supertab'


" CSApprox
" Makes GVIM themes work in terminals
Bundle 'CSApprox'


" Theme Bundle
Bundle 'flazz/vim-colorschemes'


" L9
" Dependency for a lot of plugins
Bundle 'L9'


" Line Numbers
Bundle 'myusuf3/numbers.vim'


" TComment
" https://github.com/tomtom/tcomment_vim
"
" Handles commenting of multiple lines
"    gc{motion}   :: Toggle comments (for small comments within one line 
"                    the &filetype_inline style will be used, if 
"                    defined)
"    gc<Count>c{motion} :: Toggle comment text with count argument 
"                    (see |tcomment#Comment()|)
"    gcc          :: Toggle comment for the current line
"    gC{motion}   :: Comment region
"    gCc          :: Comment the current line
"
" In visual mode:
"    gc           :: Toggle comments
"    gC           :: Comment selected text
Bundle 'tomtom/tcomment_vim'

" Easymotion
Bundle 'easymotion/vim-easymotion'


filetype plugin indent on


" ----------------------------------------
" VIM Configuration
" ----------------------------------------

" Leader
let mapleader=","

" ---------------
" Color Scheme
" ---------------
" http://agonzalezro.github.io/best-vim-colors-ever.html
" colorscheme desertEx
" colorscheme jellybeans
" colorscheme wombat256mod
set t_Co=256
colorscheme jellybeans
syntax on

" Config
set number                      "Turn on line-numbers
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set undolevels=700              "Store lots of undo's in history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set autoread                    "Reload files changed outside vim
set nowrap                      "Don't wrap lines
set linebreak                   "Wrap lines at convenient points

" Scrolling
set scrolloff=4         "Start scrolling when we're 4 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Turn off swap files
set noswapfile
set nobackup
set nowb

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Say no to code folding...
set nofoldenable

" Disable K looking stuff up
map K <Nop>

" (Hopefully) removes the delay when hitting esc in insert mode
"set noesckeys
set ttimeout
set ttimeoutlen=1

" Yanks go on clipboard instead.
set clipboard+=unnamed

" Show matching brackets.
set showmatch

" Search
set incsearch        "Find the next match as we type the search
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
set ignorecase
set smartcase


" Persistent Undo
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif


" Tab Settings
" Standard tab shortcuts:
" gt -> go to next tab
" gT -> go to previous tab
" nnn gt -> go to nnn tab
"
" NOTE: "C-tab", does not work in terminals,
" because terminals does not support it
" and will just send "tab" instead.
"nnoremap <C-S-tab> :tabprevious<CR>
"nnoremap <C-tab>   :tabnext<CR>
"nnoremap <C-t>     :tabnew<CR>
"inoremap <C-S-tab> <Esc>:tabprevious<CR>i
"inoremap <C-tab>   <Esc>:tabnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR>
" Mapping to alt+arrow instead
nnoremap <A-left>   :tabprevious<CR>
nnoremap <A-right>  :tabnext<CR>
nnoremap <C-t>      :tabnew<CR>
inoremap <A-left>   <Esc>:tabprevious<CR>i
inoremap <A-right>  <Esc>:tabnext<CR>i
inoremap <C-t>      <Esc>:tabnew<CR>


" Indentation
set pastetoggle=<F2> " Press F2 in insert mode for better paste
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" easier moving of code blocks
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

" Undo/redo
:map <C-z> <Esc>u<CR>
" ctrl + r redo
":map <C-Z> <Esc>:redo<CR>

" Format Help
" easier formatting of paragraphs
" with line-breaks
vmap Q gq
nmap Q gqap

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·


" Spelling
" Correct word:
"   z=
" Add word:
"   zg
nmap <silent> <leader>sp :set spell!<CR>
setlocal spell spelllang=en_us
" hi clear SpellBad
" hi SpellBad cterm=underline ctermfg=red
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set nospell

" copy'n'paste multisession
" Shift+y will yank the selection to work
" with multiple sessions of VIM
"
" Copy the current visual slection to ~/.vbuf
vmap <S-y> :w! ~/.vbuf<CR>
" Copy the current line to the buffer file if no visual selection
nmap <S-y> :.w! ~/.vbuf<CR>
" Paste the contents of the buffer file
nmap <S-p> :r ~/.vbuf<CR>

" Fixes common typos
command W w
command Q q
map <F1> <Esc>
imap <F1> <Esc>

" Word wrap
au BufRead,BufNewFile *.md,*.tex set wrap linebreak nolist textwidth=0 wrapmargin=0


" Auto Commands
if has("autocmd")
  " No more complaining about untitled documents
  autocmd FocusLost silent! :wa

  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line ("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif


" Window Movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" ----------------------------------------
" User Experience
" ----------------------------------------

" UI
if has('cmdline_info')
  set ruler                   " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd                 " show partial commands in status line and
endif
set laststatus=2  " Always show the statusline
set cmdheight=2


" ----------------------------------------
" Bundles/Plugin Configuration
" ----------------------------------------

" TagBar
map <leader>l :TagbarToggle<CR>

" SuperTab
let g:SuperTabDefaultCompletionType = "context"


" closetag.vim
" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php"


" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'hklyuiopnmqwertasdgzxcvbjf'
let g:EasyMotion_use_upper = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
map  f <Plug>(easymotion-s2)
xmap f <Plug>(easymotion-s2)
omap f <Plug>(easymotion-t2)
map J <Plug>(easymotion-j)
map K <Plug>(easymotion-k)
hi link EasyMotionTarget Todo
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First Todo
hi link EasyMotionTarget2Second Todo
hi link EasyMotionIncSearch IncSearch
hi link EasyMotionIncCursor Search


" Numbers
" Only show relative numbers in visual mode
let g:enable_numbers = 0

" :au FocusLost * :set number
" :au FocusGained * :set relativenumber
"
" autocmd InsertEnter * :set number
" autocmd InsertLeave * :set relativenumber
" set relativenumber


" TODO Does this work?
" Colorize line numbers in insert and visual modes
" ------------------------------------------------
function! SetCursorLineNrColorInsert(mode)
    " Insert mode: blue
    if a:mode == "i"
        highlight CursorLineNr ctermfg=4 guifg=#268bd2

    " Replace mode: red
    elseif a:mode == "r"
        highlight CursorLineNr ctermfg=1 guifg=#dc322f

    endif
endfunction


function! SetCursorLineNrColorVisual()
    set updatetime=0

    " Visual mode: orange
    highlight CursorLineNr cterm=none ctermfg=9 guifg=#cb4b16
endfunction


function! ResetCursorLineNrColor()
    set updatetime=4000
    highlight CursorLineNr cterm=none ctermfg=0 guifg=#073642
endfunction


" vnoremap <silent> <expr> <SID>SetCursorLineNrColorVisual SetCursorLineNrColorVisual()
" nnoremap <silent> <script> v v<SID>SetCursorLineNrColorVisual
" nnoremap <silent> <script> V V<SID>SetCursorLineNrColorVisual
" nnoremap <silent> <script> <C-v> <C-v><SID>SetCursorLineNrColorVisual


augroup CursorLineNrColorSwap
    autocmd!
    autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
    autocmd InsertLeave * call ResetCursorLineNrColor()
    autocmd CursorHold * call ResetCursorLineNrColor()
augroup END



" ----------------------------------------
" Functions
" ----------------------------------------

" Rename File
" Easy way of re-naming file when editing it
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

map <Leader>re :call RenameFile()<cr>


" ----------------------------------------
" Thinkpad X1 Configuration
" ----------------------------------------

" ---------------
" Home/End
" ---------------
" Shortcuts for Home/end because my home/end is position
" crap on my thinkpad
" Ctrl+Shift+Left/Right -> Home/End
nnoremap <C-S-Left> <Home>
inoremap <C-S-Left> <Home>
nnoremap <C-S-Right> <End>
inoremap <C-S-Right> <End>


" ----------------------------------------
" Sunray Settings
" ----------------------------------------
" associate *.src with fortran filetype
au BufRead,BufNewFile *.src setfiletype fortran


