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

