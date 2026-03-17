-- Base vim settings

-- vim.o: behaves like :let &{option-name}
-- vim.go: behaves like :let &g:{option-name}
-- vim.bo: behaves like :let &l:{option-name} for buffer-local options
-- vim.wo: behaves like :let &l:{option-name} for window-local options

-- vim.opt: behaves like :set
-- vim.opt_global: behaves like :setglobal
-- vim.opt_local: behaves like :setlocal

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 0
vim.opt.tabstop = 4

vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.list = true -- Highlight unwanted spaces
vim.opt.listchars = {
  tab = "│·",
  trail = "·",
  -- eol = '↵',
}
vim.opt.mouse = "a"
vim.opt.hlsearch = false -- I don't like to look at highlighted text
vim.opt.showmode = false -- insert is already showing in lightline
vim.opt.swapfile = false
vim.opt.wrap = false -- Don't ever wordwrap my code
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8 -- I like cursor to be in center
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 15
vim.opt.signcolumn = "yes:1" -- always show sign column (bookmarks, gitgutter,..)
vim.opt.smartcase = true -- if a pattern contains an uppercase letter, it is case sensitive

vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildignore = {
  "*.pyc",
  "*_build/*",
  "**/coverage/*",
  "**/node_modules/*",
  "**/ios/*",
  "**/.git/*",
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
    vim.opt_local.expandtab = false
  else
    vim.opt_local.expandtab = true
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
    if string.sub(line, i, i) == " " then
      whitespace = whitespace + 1
    else
      break
    end
  end

  vim.opt_local.shiftwidth = whitespace
  vim.opt_local.tabstop = whitespace
end

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    _G._autocommands.is_space_or_tab()
  end,
})

-- Overwrite default behavior
vim.api.nvim_create_user_command("W", "w", {}) -- common typo
vim.api.nvim_create_user_command("Q", "q", {}) -- common typo

-- More sane undo (undo breakpoints on char)
vim.keymap.set("i", '"', '"<C-g>u')
vim.keymap.set("i", "(", "(<C-g>u")
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", "[", "[<C-g>u")

-- I feel like going back a word should be consistent with w
vim.keymap.set({ "n", "v" }, "W", "b")

-- Move marked text (Sorry Peter, I use arrow)
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<C-j>", "<esc>:m .+1<CR>==i")
vim.keymap.set("i", "<C-k>", "<esc>:m .-2<CR>==i")
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-Down>", "<esc>:m .+1<CR>==i")
vim.keymap.set("i", "<A-Up>", "<esc>:m .-2<CR>==i")
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==")

-- Delete without yank
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("n", "D", '"_D')
vim.keymap.set("v", "d", '"_d')
vim.keymap.set("n", "c", '"_c')

-- Keep me centered when jumping
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")

-- Keep me centered when going up and down
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<PageUp>", "<PageUp>zz")
vim.keymap.set("n", "<PageDown>", "<PageDown>zz")

-- Reselect visual selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")

-- Set default behavior for filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "*.mdx", "*.markdown" },
  callback = function()
    vim.bo.filetype = "markdown"
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Jenkinsfile", "*.Jenkinsfile" },
  callback = function()
    vim.bo.filetype = "groovy"
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.src",
  callback = function()
    vim.bo.filetype = "fortran"
  end,
})

-- Fortran globals
vim.g.fortran_more_precise = 1
vim.g.fortran_dialect = "f77"

-- Filetype detection (needed for doge#generate)
vim.cmd("filetype plugin on")

-- Spelling
vim.opt.spelllang = "en"
vim.opt.spellsuggest = "best,10" -- show only the top 10 candidates

-- Update buffer if file has changed on disk
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- Useful commands
-- SortWords: sort words on current line split by space
-- Sw: sudo write to file
vim.api.nvim_create_user_command("SortWords", function(opts)
  local line = vim.fn.getline(opts.line1)
  vim.fn.setline(opts.line1, table.concat(vim.fn.sort(vim.split(line, " ")), " "))
end, { range = true })
vim.api.nvim_create_user_command("Sw", "w !sudo tee % > /dev/null", {})

-- If diff mode, ignore whitespace
if vim.wo.diff then
  vim.opt.diffopt:append("iwhite")
end

-- Quote words
vim.keymap.set("n", '<Leader>q"', 'ciw""<Esc>P', { desc = "Surround word with double quotes" })
vim.keymap.set("n", "<Leader>q'", "ciw''<Esc>P", { desc = "Surround word with single quotes" })
vim.keymap.set("n", "<Leader>qd", 'daW"=substitute(@@,"\'\\|"","","g")<CR>P', { desc = "Remove surrounding quotes" })
