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
      _G._autocommands.find_indent_width(lines_spaces)
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

