" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Disable underline in html documents
let html_no_rendering=1


"custom copy'n'paste
"copy the current visual selection to ~/.vbuf
vmap <S-y> :w! ~/.vbuf<CR>
"copy the current line to the buffer file if no visual selection
nmap <S-y> :.w! ~/.vbuf<CR>
"paste the contents of the buffer file
nmap <S-p> :r ~/.vbuf<CR>


" ================ Generel Settings  ================
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set undolevels=700              "Store lots of undo's in history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set autoread                    "Reload files changed outside vim
set nowrap                      "Don't wrap lines
set linebreak                   "Wrap lines at convenient points

" Width of document
"set tw=79                       "Width of document (used by gd)
"set colorcolumn=80              "Visually show the width of document
"highlight ColorColumn ctermbg=black "Change the color too a dark one

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" turn on syntax highlighting
syntax on


" ================ Search Settings  =================
set incsearch        "Find the next match as we type the search
"set hlsearch         "Hilight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
set ignorecase
set smartcase


" ================ Tab Settings =====================
" I have Tab settings like any other program with ctrl+tab
" because i use xterm, should be something else,
" if you use gnome or something with tabs
"
" NOTE: "C-tab", does not work in xterm,
" because xterm does not support it
" and will just send "tab" instead.
"nnoremap <C-S-tab> :tabprevious<CR>
"nnoremap <C-tab>   :tabnext<CR>
"nnoremap <C-t>     :tabnew<CR>
"inoremap <C-S-tab> <Esc>:tabprevious<CR>i
"inoremap <C-tab>   <Esc>:tabnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR>
nnoremap <A-left>   :tabprevious<CR>
nnoremap <A-right>  :tabnext<CR>
nnoremap <C-t>      :tabnew<CR>
inoremap <A-left>   <Esc>:tabprevious<CR>i
inoremap <A-right>  <Esc>:tabnext<CR>i
inoremap <C-t>      <Esc>:tabnew<CR>


" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb


" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile


" ================ Indentation ======================
set pastetoggle=<F2> " Press F2 in insert mode for better paste
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

" TODO Not sure what these does:
filetype plugin on
filetype indent on

" easier moving of code blocks
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

set list listchars=tab:\ \ ,trail:· " Display tabs and trailing spaces visually


" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default


" ================ Completion =======================
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif


" ================ Scrolling ========================
set scrolloff=4         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

