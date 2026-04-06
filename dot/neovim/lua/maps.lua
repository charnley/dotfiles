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

-- Clipboard: use Neovim's built-in OSC 52 provider (requires Neovim 0.10+)
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}
vim.opt.clipboard = "unnamedplus"

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

-- Spelling
-- Add word: zg
-- Correct word: z=
vim.api.nvim_set_keymap("n", "<Leader>z", ":set spell!<cr>", { desc = "Toggle spellmode" })

-- Git commands
vim.api.nvim_set_keymap("n", "<leader>gu", ":GitGutterUndoHunk<cr>", { noremap = true, desc = "Undo git hunk" })
vim.api.nvim_set_keymap("n", "<leader>gn", ":GitGutterNextHunk<cr>", { noremap = true, desc = "Next git hunk" })
vim.api.nvim_set_keymap("n", "<leader>gp", ":GitGutterPrevHunk<cr>", { noremap = true, desc = "Prev git hunk" })
vim.api.nvim_set_keymap("n", "<leader>gh", ":GitGutterPreviewHunk<cr>", { noremap = true, desc = "Diff hunk" }) -- what changed in this hunk (close with :pclose)
vim.api.nvim_set_keymap("n", "<leader>gb", ":BlameToggle<cr>", { noremap = true, desc = "Toggle git blame" }) -- Undo block of git changes

-- Visual change: delete without yanking
vim.api.nvim_set_keymap("v", "c", '"_c', { noremap = true, desc = "Change without yanking" })

-- Cut to clipboard commands
vim.api.nvim_set_keymap("n", "<leader>d", '"+dd', { noremap = true, desc = "Cut line to clipboard" })
vim.api.nvim_set_keymap("v", "<leader>d", '"+d', { noremap = true, desc = "Cut to clipboard" })
vim.api.nvim_set_keymap("n", "<leader>D", '"+D', { noremap = true, desc = "Cut rest of line to clipboard" })

-- Lsp key bindings
vim.keymap.set("n", "<Leader>ld", vim.lsp.buf.definition, { desc = "LSP definition" })
vim.keymap.set("n", "<Leader>lD", vim.lsp.buf.declaration, { desc = "LSP declaration" })
vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.references, { desc = "LSP references" })
vim.keymap.set("n", "<Leader>li", vim.lsp.buf.implementation, { desc = "LSP implementation" })
vim.keymap.set("n", "<Leader>lh", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
vim.keymap.set("n", "<Leader>lf", function()
  vim.lsp.buf.format()
end, { desc = "LSP format" })
vim.keymap.set("n", "<Leader>ln", vim.lsp.buf.rename, { desc = "LSP rename" })

-- Jump forward or backward in snippets
vim.keymap.set(
  "i",
  "<Tab>",
  "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
  { expr = true, desc = "Snippet jump next" }
)
vim.keymap.set(
  "i",
  "<S-Tab>",
  "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
  { expr = true, desc = "Snippet jump prev" }
)

local opts = { noremap = true, silent = true }
vim.keymap.set(
  "n",
  "<Leader>lun",
  vim.diagnostic.goto_next,
  vim.tbl_extend("force", opts, { desc = "Next diagnostic" })
)
vim.keymap.set(
  "n",
  "<Leader>lup",
  vim.diagnostic.goto_prev,
  vim.tbl_extend("force", opts, { desc = "Prev diagnostic" })
)

-- Create file next to current buffer
vim.keymap.set("n", ",e", function()
  return ":e " .. vim.fn.expand("%:p:h") .. "/"
end, { expr = true, desc = "Edit file in current dir" })

-- Surround text with html tag
-- TODO vim.api.nvim_set_keymap('n', '<leader>ns', '<tag></tag>?>p', {noremap = true, desc='Surround text with html tag'})
