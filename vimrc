" - add fortran?

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Leader
let mapleader=","

if !has('gui_running')
  set t_Co=256
endif


" ----------------------------------------
" https://github.com/junegunn/vim-plug
" ----------------------------------------


filetype off


call plug#begin()
" PlugInstall
" PlugUpgrade
" PlugClean!

" css colors
Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'sass', 'scss', 'stylus', 'vim'] }

" let html tags be close automatic
Plug 'alvan/vim-closetag'

" bookmarks
Plug 'MattesGroeger/vim-bookmarks'
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
" highlight BookmarkSign ctermbg=NONE ctermfg=160
" highlight BookmarkLine ctermbg=194 ctermfg=NONE
" let g:bookmark_sign = 'B'
let g:bookmark_sign = '♥'


" let Vundle manage Vundle
Plug 'gmarik/vundle'


" Tagbar
Plug 'majutsushi/tagbar'


" Supertab
" https://github.com/ervandew/supertab
" Plug 'ervandew/supertab'

" Syntax checker
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_sign_warning = '▴'
let g:ale_sign_error = 'X'
" Clear the background colors of ALe
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
" TODO add fortran 77 support,
" removed fortran support until i find solution
let g:ale_linters = {
    \   'fortran': [],
    \   'python': [],
    \}


" underscore is too common a false-positive error
" for urls and files
let tex_no_error=1

" completer
" snippets

" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Track custom snippets
" reads ~/.vim/snippets automatic

" CSApprox
" Makes GVIM themes work in terminals
" Plug 'vim-scripts/CSApprox'
" Plug 'dracula/vim'
Plug 'nanotech/jellybeans.vim'


" Theme Plug
Plug 'flazz/vim-colorschemes'
Plug 'nanotech/jellybeans.vim'
Plug 'tomasiser/vim-code-dark'


" L9
" Dependency for a lot of plugins
Plug 'vim-scripts/L9'

" gitgutter see where the file is changed
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
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

" Line Numbers
"set relativenumber

" TODO read up and integrate
" https://github.com/terryma/vim-multiple-cursorsa

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
Plug 'tomtom/tcomment_vim'

" Easymotion (find char, f)
Plug 'easymotion/vim-easymotion'
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


" fzf
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Bottomline
Plug 'itchyny/lightline.vim'
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'component': {
	\   'readonly': '%{&readonly?"x":""}',
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
	\ }


" Use release branch (Recommend)
" IDE like behavior
" install coc plugins?
" - coc-python
" - coc-pylint
" - coc-snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


" Indentation lines
" usage: <leader>ig
Plug 'nathanaelkane/vim-indent-guides'

" keep vim sessions
Plug 'tpope/vim-obsession'


" Write mode
Plug 'junegunn/goyo.vim'
let g:goyo_height= '80%'
let g:goyo_width = '80'

function! s:goyo_enter()
    silent !tmux set status off
    " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set noshowmode
    set noshowcmd
    set scrolloff=999

    ALEDisable
    set wrap
    Goyo 80x100%
endfunction

function! s:goyo_leave()
    silent !tmux set status on
    " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    set showmode
    set showcmd
    set scrolloff=5

    ALEEnable
    set nowrap
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nmap <silent> <leader>w :Goyo<CR>

" On window resize, if goyo is active, do <c-w>= to resize the window
autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif

" Auto ident
Plug 'ldx/vim-indentfinder'

call plug#end()



" ---------------
" Navigation
" ---------------

" Turn off linewise keys. This is especially important when working with word
" wrap documents
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
"
" nnoremap <Home> g<Home>
" nnoremap <End> g<End>
" inoremap <Home> <C-o>g<Home>
" inoremap <End> <C-o>g<End>

" noremap  <buffer> <silent> <Up>   gk
" noremap  <buffer> <silent> <Down> gj
" noremap  <buffer> <silent> <Home> g<Home>
" noremap  <buffer> <silent> <End>  g<End>
" inoremap <buffer> <silent> <Up>   <C-o>gk
" inoremap <buffer> <silent> <Down> <C-o>gj
" inoremap <buffer> <silent> <Home> <C-o>g<Home>
" inoremap <buffer> <silent> <End>  <C-o>g<End>

function EnableDisplayWrapping()
  if !&wrap
	setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

function DisableDisplayWrapping()
  if &wrap
    setlocal nowrap
    nunmap <buffer> <Up>
    nunmap <buffer> <Down>
    iunmap <buffer> <Up>
    iunmap <buffer> <Down>
    vunmap <buffer> <Up>
    vunmap <buffer> <Down>
  endif
endfunction



" " Peter is going to hate this for sure
" map i <Up>
" map j <Left>
" map k <Down>
" " swap h and i
" noremap h i
"
" " Window Movement
" " TODO buggy fix it
" map <C-i> <C-w>i
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l



" " FILE NAVIGATION
"
" Tabs:
"   gt -> go to next tab
"   gT -> go to previous tab
"   nnn gt -> go to nnn tab
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
nnoremap <C-t>      <Esc>:tabnew<enter>:FZF<CR>
inoremap <A-left>   <Esc>:tabprevious<CR>i
inoremap <A-right>  <Esc>:tabnext<CR>i
inoremap <C-t>      <Esc>:tabnew<enter>:FZF<CR>

" TODO should be GitFiles or something when opening files

" TODO I want to open Buffers, and if not found I want to open GitFiles

" Search open files
nnoremap <Leader>b :Buffers<cr>

" Search lines in current buffer
noremap <Leader>s :BLines<cr>

" Open new file
" :FZF searches all files
" GitFiles searches git-files
noremap <leader>f :GitFiles<CR>

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>


" TODO add movement via multiple windows



" These are things that I mistype and want ignored.
nmap Q  <silent>
nmap q: <silent>
nmap K  <silent>


"
nmap ; :Buffers<CR>


" ---------------
" Color Scheme
" ---------------
" http://agonzalezro.github.io/best-vim-colors-ever.html
" colorscheme desertEx
colorscheme jellybeans
" colorscheme wombat256mod
" colorscheme codedark
set t_Co=256
set t_ut=
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
" try
"     let g:codedark_conservative = 0
"     colorscheme codedark
" catch
"     set background=dark
" endtry
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
" autocmd BufRead,BufEnter *.css setlocal foldmethod=marker
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



nmap ^[{ :tabnext<cr>
imap ^[{ <ESC>:tabnext<cr>
nmap ^[} :tabprevious<cr>
imap ^[} <ESC>:tabprevious<cr>

" Indentation
" set paste
" set nopaste
set pastetoggle=<F2> " Press F2 in insert mode for better paste
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" do not convert tab to space for these filetypes
" do not change it for makefiles
autocmd FileType make setlocal noexpandtab
autocmd FileType cpp setlocal noexpandtab

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

" Don't mark URL-like things as spelling errors
syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

" Don't count acronyms / abbreviations as spelling errors
" (all upper-case letters, at least three characters)
" Also will not count acronym with 's' at the end a spelling error
" Also will not count numbers that are part of this
" Recognizes the following as correct:
syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell

" No spelling as default
set nospell

" copy'n'paste multisession
" Shift+y will yank the selection to work
" with multiple sessions of VIM
" https://sunaku.github.io/tmux-yank-osc52.html

function! OscCopyVbuf()
  let executeCmd='yank ~/.vbuf'
  call system(executeCmd)
  redraw!
endfunction
command! OscCopyVbuf :call OscCopyVbuf()

function! OscYank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
noremap <silent> <Leader>y y:<C-U>call OscYank(@0)<CR>

" Copy the current visual slection to ~/.vbuf
vmap <S-y> :w! ~/.vbuf<CR>
" Copy the current line to the buffer file if no visual selection
nmap <S-y> :.w! ~/.vbuf<CR>
" Paste the contents of the buffer file
nmap <S-p> :r ~/.vbuf<CR>


" Fixes common typos
command W w
command Q q
" map <F1> <Esc>
" imap <F1> <Esc>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Word wrap
" au BufRead,BufNewFile *.md,*.tex set wrap linebreak nolist textwidth=0 wrapmargin=0


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
set cmdheight=1


" ----------------------------------------
" Plugs/Plugin Configuration
" ----------------------------------------

" indentation
" hi IndentGuidesOdd  ctermbg=black
" hi IndentGuidesEven ctermbg=darkgrey

" user experience





" TagBar
map <leader>l :TagbarToggle<CR>


" Numbers
" Only show relative numbers in visual mode
let g:enable_numbers = 0

" :au FocusLost * :set number
" :au FocusGained * :set relativenumber
"
" autocmd InsertEnter * :set number
" autocmd InsertLeave * :set relativenumber
" set relativenumber



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

" ---------------
" vimdiff
" ---------------
if &diff
    " ignore whitespace in diffmode
    set diffopt+=iwhite
endif

" ----------------------------------------
" GAMESS Settings
" ----------------------------------------
" associate *.src with fortran filetype
au BufRead,BufNewFile *.src setfiletype fortran
" au BufRead,BufNewFile *.F90 setfiletype fortran

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


" :w!!
" write the file when you accidentally opened it without the right (root) privileges
cmap w!! w !sudo tee % > /dev/null


" Ignore whitespace diff mode
if &diff
    " diff mode
    set diffopt+=iwhite
endif


" mouse
set mouse=a " mouse in all modes
"set mouse=i " mouse insert mode only
set ttymouse=xterm


" backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set nobackup nowritebackup

