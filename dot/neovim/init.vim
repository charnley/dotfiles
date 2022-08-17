" NEO VIM Configuration

" TODO https://github.com/elianiva/dotfiles/tree/master/nvim/.config/nvim

" TODO https://github.com/junegunn/vim-easy-align " Easy align CSV data
" TODO
" Plug 'pangloss/vim-javascript' "JS support
" Plug 'leafgarland/typescript-vim' "TS support
" Plug 'maxmellon/vim-jsx-pretty' "JS and JSX syntax
" Plug 'jparise/vim-graphql' "GraphQL syntax
" TODO Plug 'mattn/emmet-vim' " Powerfull HTML expansion
" TODO Write mode rhysd/vim-grammarous
" TODO https://github.com/folke/zen-mode.nvim
" TODO https://github.com/mizlan/dotfiles/blob/master/.config/nvim/init.lua
" TODO https://github.com/romainl/vim-cool

lua << EOF
require'plugins'
EOF

lua << EOF
require'base'
EOF

lua << EOF
require'maps'
EOF

lua << EOF
require'gui'
EOF

" Search open files
" nnoremap <Leader>b :Buffers<cr>

" Search lines in current buffer
" noremap <Leader>s :BLines<cr>

" Search all files registered with git
" noremap <leader>f :GitFiles<CR>

" Search all files under current directory
" noremap <leader>o :Files<CR>

" Switch between buffers
" map bn :bnext<cr>
" map bp :bprevious<cr>
" map bd :bdelete<cr>

" Much like a browser, just tab between buffers
" nmap <Tab> :bnext<CR>
" nmap <S-Tab> :bprevious<CR>

" Copy to clipboard using ~/bin/yank
" function! OscCopyVbuf()
"     let executeCmd='yank ~/.vbuf'
"     call system(executeCmd)
"     mod " redraw the interface
" endfunction

" function! OscYank(text) abort
"     let escape = system('yank', a:text)
"     if v:shell_error
"         echoerr escape
"     else
"         call writefile([escape], '/dev/tty', 'b')
"     endif
"     mod " Redraw the interface
" endfunction

" command! OscCopyVbuf :call OscCopyVbuf()
" noremap <silent> <Leader>y y:<C-U>call OscYank(@0)<CR>

" Copy the current visual slection to ~/.vbuf
" Copy the current line to the buffer file if no visual selection
" Paste the contents of the buffer file
" vmap <S-y> :w! ~/.vbuf<CR>
" nmap <S-y> :.w! ~/.vbuf<CR>
" nmap <S-p> :r ~/.vbuf<CR>

" When pasting a lot of code
" nnoremap <Leader>p :set invpaste<CR>

" " copy rest of the line
" nnoremap Y y$

" " More sane undo (undo breakpoints on char)
" inoremap " "<c-g>u
" inoremap ( (<c-g>u
" inoremap , ,<c-g>u
" inoremap . .<c-g>u
" inoremap [ [<c-g>u

" " I feel like going back a word should be consistent with w
" nnoremap W b
" vnoremap W b

" " Move marked text (Sorry Peter, I use arrow)
" vnoremap <C-j> :m '>+1<CR>gv=gv
" vnoremap <C-k> :m '<-2<CR>gv=gv
" inoremap <C-j> <esc>:m .+1<CR>==i
" inoremap <C-k> <esc>:m .-2<CR>==i
" nnoremap <C-j> :m .+1<CR>==
" nnoremap <C-k> :m .-2<CR>==
" vnoremap <A-Down> :m '>+1<CR>gv=gv
" vnoremap <A-Up> :m '<-2<CR>gv=gv
" inoremap <A-Down> <esc>:m .+1<CR>==i
" inoremap <A-Up> <esc>:m .-2<CR>==i
" nnoremap <A-Down> :m .+1<CR>==
" nnoremap <A-Up> :m .-2<CR>==

" " Delete without yank
" nnoremap d "_d
" nnoremap D "_D
" vnoremap d "_d

" " Cut (Delete & Yank) enabled via leader
" nnoremap <leader>d ""d
" nnoremap <leader>D ""D
" vnoremap <leader>d ""d

" " keep me centered when jumping
" nnoremap n nzzzv
" nnoremap N Nzzzv
" nnoremap J mzJ`z

" Remove all trailing whitespace by pressing F5
" nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Check wether file is space or tabs based. Switch accordingly
" function TabsOrSpaces()
"     " Determines whether to use spaces or tabs on the current buffer.
"     if getfsize(bufname("%")) > 256000
"         " File is very large, just use the default.
"         return
"     endif

"     let numTabs=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
"     let numSpaces=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^ "'))

"     if numTabs > numSpaces
"         setlocal noexpandtab
"     else
"         setlocal expandtab
"         call IndentWidth()
"     endif
" endfunction


" function IndentWidth()

"     let spaceLines = getline(1, 250)->map({l, v -> [l+1, v =~ '^ ']})->filter({k,v -> v[1]})->map({k,v -> v[0]})

"     " If empty file or no indentation found, use default
"     if len(spaceLines) < 1
"         return
"     endif

"     " Assume first line with spaces is indentation standard
"     let width = indent(spaceLines[0])

"     if width < 1
"         return
"     endif

"     " if indent is -1, return

"     execute "setlocal shiftwidth=".width
"     execute "setlocal tabstop=".width

" endfunction

" Call the function after opening a buffer
" autocmd BufReadPost * call TabsOrSpaces()

" Format file (bin command)
" noremap <silent> <Leader>nf :!format %<CR>

" User Interface
" if has('cmdline_info')
"   set ruler                   " show the ruler
"   set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
"   set showcmd                 " show partial commands in status line and
" endif
" set laststatus=2  " Always show the statusline
" set cmdheight=1

" Fixes common typos
" command W w
" command Q q

" Ignore white space in diffmode
" if &diff
"     set diffopt+=iwhite
" endif

" File types change
" au BufRead,BufNewFile *.md,*.mdx,*.markdown setfiletype markdown
" au BufRead,BufNewFile Jenkinsfile,*.Jenkinsfile setfiletype groovy
" au BufRead,BufNewFile *.src setfiletype fortran
" let fortran_more_precise=1
" let fortran_dialect = "f77"
" let s:extfname = expand("%:e")
" if s:extfname ==? "f90"
"     let fortran_free_source=1
"     unlet! fortran_fixed_source
" else
"     let fortran_fixed_source=1
"     unlet! fortran_free_source
" endif

" Spelling
" add word: zg
" correct spelling: z=
" set spelllang=en
" set spellsuggest=best,10  " Show only the top ten candidates
" nnoremap <silent> <F11> :set spell!<cr>
" inoremap <silent> <F11> <C-O>:set spell!<cr>

" Sort words in line (usually done in visual block)
" command -nargs=0 -range SortWords <line1>,<line2>call setline('.',join(sort(split(getline('.'),' ')),' '))

" Update buffer if file has changed
" set autoread
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" Reselect visual selection after indenting
" vnoremap < <gv
" vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
" vnoremap y myy`y
" vnoremap Y myY`y  " I use Y as cross-vim copy

" call plug#begin()

"     Plug 'MattesGroeger/vim-bookmarks'  " Easy bookmark shortcuts
"     Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'sass', 'scss', 'stylus', 'vim'] }  " Preview CSS Colors
"     Plug 'chaoren/vim-wordmotion' " Better word motion
"     Plug 'justinmk/vim-sneak'  " Jump to char
"     " Plug 'easymotion/vim-easymotion'  " Jump to character
"     Plug 'junegunn/fzf', { 'do': './install --all' } " Fuzzy find searching
"     Plug 'junegunn/fzf.vim'  " Fuzzy find searching
"     Plug 'nanotech/jellybeans.vim' " colorscheme
"     Plug 'numToStr/Comment.nvim' " For Commenting gcc & gc (Treesitter support)
"     Plug 'JoosepAlviste/nvim-ts-context-commentstring' " For context comment
"     Plug 'gorkunov/smartpairs.vim' " Extend visual selection of bracket

"     " Interface
"     Plug 'vim-airline/vim-airline'
"     Plug 'vim-airline/vim-airline-themes'
"     Plug 'folke/which-key.nvim'  " I can't remember what <leader><char> does

"     " IDE
"     Plug 'windwp/nvim-autopairs'
"     Plug 'hrsh7th/cmp-buffer'
"     Plug 'hrsh7th/cmp-nvim-lsp'
"     Plug 'hrsh7th/cmp-path'
"     Plug 'hrsh7th/cmp-vsnip'
"     Plug 'hrsh7th/nvim-cmp'
"     Plug 'hrsh7th/vim-vsnip'
"     Plug 'kabouzeid/nvim-lspinstall'
"     Plug 'neovim/nvim-lspconfig'
"     Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"     Plug 'nvim-treesitter/nvim-treesitter-textobjects'
"     Plug 'rafamadriz/friendly-snippets'
"     Plug 'ray-x/lsp_signature.nvim'  " https://github.com/ray-x/lsp_signature.nvim
"     Plug 'danymat/neogen'  " generate docstrings (with treesitter)

"     Plug 'airblade/vim-gitgutter' " Git indication
"     Plug 'APZelos/blamer.nvim' " Git blame line

"     " Svelte development
"     Plug 'evanleck/vim-svelte'
"     Plug 'pangloss/vim-javascript'
"     Plug 'HerringtonDarkholme/yats.vim'

"     " React development
"     " TODO

" call plug#end()

" TODO Need if colorscheme is there (for setup)
" let g:jellybeans_overrides = {'background': { 'ctermbg': 'none', '256ctermbg': 'none' },}
" try
"     colorscheme jellybeans
" catch /^Vim\%((\a\+)\)\=:E185/
"     " Probably first installation
" endtry

" highlight clear SignColumn  " fix bg color for SignColumn (for jellybeans)
" highlight Pmenu ctermbg=none

" " fzf
" let $FZF_DEFAULT_OPTS='--reverse'
" let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" " Airline
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#tabline#show_close_button = 0
" let g:airline_skip_empty_sections = 1
" let g:airline#extensions#tabline#tab_min_count = 2  " ignored : (
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ' '
" let g:airline#extensions#tabline#right_alt_sep = ''
" let g:airline_powerline_fonts = 0
" au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])

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
" let g:bookmark_sign = '•'

" Git
" let g:gitgutter_sign_added = '|'
" let g:gitgutter_sign_modified = '|'
" let g:gitgutter_sign_removed = '|'
" let g:gitgutter_sign_modified_removed = '|'
" highlight GitGutterAdd ctermfg=green
" highlight GitGutterChange ctermfg=yellow
" highlight GitGutterDelete ctermfg=red

" Undo block of git changes
" nmap <leader>gu <Plug>(GitGutterUndoHunk)

" " find next or prev git hunk
" nmap <leader>gn <Plug>(GitGutterNextHunk)
" nmap <leader>gp <Plug>(GitGutterPrevHunk)

" " what changed in this hunk (close with :pclose)
" nmap <leader>gh <Plug>(GitGutterPreviewHunk)
" "au CursorMoved * if gitgutter#hunk#in_hunk(line(".")) | GitGutterPreviewHunk | else | pclose | endif

" " what changed in this hunk (close with :pclose)
" nmap <leader>gb :BlamerToggle<cr>

" let g:sneak#label = 1
" let g:sneak#target_labels = 'qwertasdfgzxcv'
" " Find char: f
" let g:EasyMotion_do_mapping = 0
" let g:EasyMotion_keys = 'qwertasdfgzxcv'
" let g:EasyMotion_use_upper = 0
" let g:EasyMotion_smartcase = 1
" let g:EasyMotion_startofline = 0
" nmap  f <Plug>(easymotion-s)
" " xmap f <Plug>(easymotion-s)
" " omap f <Plug>(easymotion-t)
" " map J <Plug>(easymotion-j)
" " map K <Plug>(easymotion-k)
" hi link EasyMotionTarget Todo
" hi link EasyMotionShade  Comment
" hi link EasyMotionTarget2First Todo
" hi link EasyMotionTarget2Second Todo
" hi link EasyMotionIncSearch IncSearch
" hi link EasyMotionIncCursor Search

" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map t <Plug>Sneak_t
" map T <Plug>Sneak_T

" " Lsp key bindings
" nnoremap <Leader>ld    <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <Leader>lD    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <Leader>lr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <Leader>li    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <Leader>lh    <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <Leader>lf    <cmd>lua vim.lsp.buf.formatting()<CR>
" nnoremap <Leader>ln    <cmd>lua vim.lsp.buf.rename()<CR>

" " Jump forward or backward in snippets
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Make VIM IDE like
let beingSetup = get(g:, 'isUpdate', 0)
if !beingSetup
lua << EOF
require'ide'
EOF
endif

" On save. Would like to be on-demand, as each project has it's own per-commit rules
" source https://waylonwalker.com/vim-augroup/
" augroup waylonwalker
"     autocmd!
"     autocmd bufwritepre *.py execute 'PyPreSave'
"     autocmd bufwritepost *.py execute 'PyPostSave'
"     autocmd bufwritepost .tmux.conf execute ':!tmux source-file %' autocmd bufwritepost .tmux.local.conf execute ':!tmux source-file %'
"     autocmd bufwritepost *.vim execute ':source %'
" augroup end

" Disable filetype plugin (it overwrites tab/indentation settings)
" filetype plugin off
