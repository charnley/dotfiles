
vim.g.mapleader = ","

vim.api.nvim_set_keymap('n', '<Leader>b', ':Buffers<cr>', {noremap = true}) -- Search open files
vim.api.nvim_set_keymap('n', '<Leader>s', ':BLines<cr>', {noremap = true}) -- Search lines in current buffer
vim.api.nvim_set_keymap('n', '<leader>f', ':GitFiles<cr>', {noremap = true}) -- Search all files registered with git
vim.api.nvim_set_keymap('n', '<leader>o', ':Files<cr>', {noremap = true})  -- Search all files under current directory

-- Navigate buffers
-- Much like a browser, just tab between buffers
vim.api.nvim_set_keymap('n', 'bn', ':bnext<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', 'bp', ':bprevious<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', 'bd', ':bdelete<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<cr>', {noremap = true})

-- Yank settings
-- Send yank register zero to ocs52
vim.keymap.set("n", "<Leader>y", function()
    local content = vim.fn.getreg('0')
    local escape = vim.fn.system("yank", content)
    vim.fn.writefile({escape}, '/dev/tty', 'b')
end, {desc="Yank OSC52"})

-- Y   
-- Copy the current visual slection to ~/.vbuf
-- Copy the current line to the buffer file if no visual selection
-- Paste the contents of the buffer file
vim.keymap.set('v', '<S-y>', ':w! ~/.vbuf<cr>')
vim.keymap.set('n', '<S-y>', ':.w! ~/.vbuf<cr>')
vim.keymap.set('n', '<S-p>', ':r ~/.vbuf<cr>')
