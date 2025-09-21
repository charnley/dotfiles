-- Only sane leader
vim.g.mapleader = ","

vim.api.nvim_set_keymap("n", "<Leader>ob", ":Buffers<cr>", { noremap = true }) -- Search open files
vim.api.nvim_set_keymap("n", "<Leader>os", ":BLines<cr>", { noremap = true }) -- Search lines in current buffer
vim.api.nvim_set_keymap("n", "<leader>og", ":GitFiles<cr>", { noremap = true }) -- Search all files registered with git
vim.api.nvim_set_keymap("n", "<leader>of", ":Files<cr>", { noremap = true }) -- Search all files under current directory

-- Navigate buffers
-- Much like a browser, just tab between buffers
vim.api.nvim_set_keymap("n", "bn", ":bnext<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "bp", ":bprevious<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "bd", ":bdelete<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprevious<cr>", { noremap = true })

-- Yank settings
-- Send yank register zero to ocs52
--- neovim 0.9.0 vim.fn.writefile({escape}, '/dev/tty', 'b') does not work
-- local content = vim.fn.getreg('0')
-- local escape = vim.fn.system("yank", content)

_G._write_reg_to_file = function()
  local content = vim.fn.getreg("0")
  local filename = vim.fn.expand("$HOME/.vbuf")
  local file = assert(io.open(filename, "w"))
  file:write(content)
  file:close()
end

-- OSC52
-- src: https://github.com/lewis6991/dotfiles/blob/26d4b8d0983b1d94fd624781888c42f4edabc734/config/nvim/lua/lewis6991/clipboard.lua

local N = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function encode_base64(data)
  local data1 = (
    data:gsub(
      ".",
      --- @param x string
      --- @return string
      function(x)
        local r, b = "", x:byte()
        for i = 8, 1, -1 do
          r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
        end
        return r
      end
    ) .. "0000"
  )

  local data2 = data1:gsub(
    "%d%d%d?%d?%d?%d?",
    --- @param x string
    --- @return string
    function(x)
      if #x < 6 then
        return ""
      end
      local c = 0
      for i = 1, 6 do
        c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
      end
      return N:sub(c + 1, c + 1)
    end
  )

  local suffix = ({ "", "==", "=" })[#data % 3 + 1]

  return data2 .. suffix
end

local function osc52_copy(text)
  local text_b64 = encode_base64(text)
  local osc = string.format("%s]52;c;%s%s", string.char(0x1b), text_b64, string.char(0x07))
  io.stderr:write(osc)
end

_G._write_reg_to_clipboard = function()
  local content = vim.fn.getreg("0")

  -- local escape = vim.fn.system("yank", content)
  -- local filename = vim.fn.expand('$HOME/.vbufb')
  -- local file = assert(io.open(filename, "w"))
  -- file:write(escape)
  -- file:close()

  -- local f = io.popen('yank', 'w')
  -- f:write(content)
  -- f:close()

  osc52_copy(content)

  -- DEPRECATED local escape = vim.fn.system("yank", content)
  -- DEPRECATED vim.fn.writefile({escape}, '/dev/tty', 'b')
end

-- Send yank to osc52 by default
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    osc52_copy(vim.fn.getreg(vim.v.event.regname))
  end,
})

vim.keymap.set("n", "<Leader><S-y>", ":lua _write_reg_to_file()<CR>", { desc = "Yank to file" })
vim.keymap.set("n", "<Leader>y", ":lua _write_reg_to_clipboard()<CR>", { desc = "Yank to clipboard" })

-- Y
-- Copy the current visual slection to ~/.vbuf
-- Copy the current line to the buffer file if no visual selection
-- Paste the contents of the buffer file
vim.keymap.set("v", "<S-y>", ":w! ~/.vbuf<cr>")
vim.keymap.set("n", "<S-y>", ":.w! ~/.vbuf<cr>")
vim.keymap.set("n", "<S-p>", ":r ~/.vbuf<cr>")

-- Remove all white trails
vim.keymap.set(
  "n",
  "<Leader>nw",
  [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]],
  { desc = "Remove whitespaces" }
)

-- Format buffer
vim.api.nvim_set_keymap("n", "<Leader>nf", ":!format %<cr>", { silent = true, noremap = true, desc = "Format file" })

-- Use paste mode
vim.api.nvim_set_keymap("n", "<Leader>p", ":set invpaste<cr>", { desc = "Toggle pastemode" }) -- for that stackoverflow

-- Spelling
-- Add word: zg
-- Correct word: z=
vim.api.nvim_set_keymap("n", "<Leader>z", ":set spell!<cr>", { desc = "Toggle spellmode" })

-- Git commands
vim.api.nvim_set_keymap("n", "<leader>gu", ":GitGutterUndoHunk<cr>", { noremap = true, desc = "Undo git hunk" })
vim.api.nvim_set_keymap("n", "<leader>gn", ":GitGutterNextHunk<cr>", { noremap = true, desc = "Next git hunk" })
vim.api.nvim_set_keymap("n", "<leader>gp", ":GitGutterPrevHunk<cr>", { noremap = true, desc = "Prev git hunk" })
vim.api.nvim_set_keymap("n", "<leader>gh", ":GitGutterPreviewsHunk<cr>", { noremap = true, desc = "Diff hunk" }) -- what changed in this hunk (close with :pclose)
vim.api.nvim_set_keymap("n", "<leader>gb", ":BlameToggle<cr>", { noremap = true, desc = "Toggle git blame" }) -- Undo block of git changes

-- Cut commands
vim.api.nvim_set_keymap("n", "<leader>d", '""dd', { noremap = true, desc = "Cut line" })
vim.api.nvim_set_keymap("v", "<leader>d", '""d', { noremap = true, desc = "Cut" })
vim.api.nvim_set_keymap("n", "<leader>D", '""D', { noremap = true, desc = "Cut rest of line" })

-- Lsp key bindings
vim.api.nvim_exec(
  [[
nnoremap <Leader>ld    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>lD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>lr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <Leader>li    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>lh    <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>lf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <Leader>ln    <cmd>lua vim.lsp.buf.rename()<CR>

" Jump forward or backward in snippets
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]],
  false
)

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>lun", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>lup", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

-- Crate file nest to current buffer
vim.api.nvim_exec(
  [[
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
]],
  false
)

-- Surround text with html tag
-- TODO vim.api.nvim_set_keymap('n', '<leader>ns', '<tag></tag>?>p', {noremap = true, desc='Surround text with html tag'})
