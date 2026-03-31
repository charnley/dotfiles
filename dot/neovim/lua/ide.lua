-- More like IDE

require("nvim-autopairs").setup({})
require("which-key").setup({})

-- Be able to comment html and js in same file
require("ts_context_commentstring").setup({})

-- Auto signature hints
require("lsp_signature").setup({

  handler_opts = {
    border = "single", -- double, rounded, single, shadow, none
  },
  hint_prefix = "", -- Panda for parameter
})

-- locals
local lsp = vim.lsp
local handlers = lsp.handlers
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- add brackets after auto-complete
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- comment
require("Comment").setup({
  ignore = "^$",
  pre_hook = function(ctx)
    local U = require("Comment.utils")

    local location = nil
    if ctx.ctype == U.ctype.blockwise then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    local commentstr = require("ts_context_commentstring.internal").calculate_commentstring({
      key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline",
      location = location,
    })
    return commentstr
  end,
})

local ft = require("Comment.ft")
ft.set("fortran", "!%s")

-- docstring
-- generate docstring
require("neogen").setup({
  languages = {
    -- TODO This does not work, super annoying
    ["svelte"] = require("neogen.configurations.javascript"),
  },
})
vim.api.nvim_set_keymap(
  "n",
  "<Leader>nd",
  ":lua require('neogen').generate()<CR>",
  { noremap = true, silent = true, desc = "Generate docstring" }
)

-- Doge
-- Open nvim and run :call doge#install()
vim.keymap.set("n", "<Leader>nD", "<Plug>(doge-generate)", { desc = "Doge generate docstring" })

-- setup completion
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  }, -- end snippet
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<leader>"] = cmp.mapping({ -- quickly cancel when I want the menu gone
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<Down>"] = cmp.mapping(
      cmp.mapping.select_next_item({
        behavior = cmp.SelectBehavior.Select,
      }),
      { "i", "c" }
    ),
    ["<Up>"] = cmp.mapping(
      cmp.mapping.select_prev_item({
        behavior = cmp.SelectBehavior.Select,
      }),
      { "i", "c" }
    ),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  }, -- end mapping
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "vsnip" },
  }, {
    -- I don't need completion on text, especially not for small words
    { name = "buffer", keyword_length = 6 },
  }), -- end sources
  experimental = {
    ghost_text = true, -- write out the auto completetion
  },
})

-- lsp setup
-- Configure diagnostics display
vim.diagnostic.config({
  virtual_text = {
    prefix = "!",
    spacing = 2,
  },
  signs = true,
  underline = true,
})

--- Treesitter
-- The new nvim-treesitter rewrite no longer uses nvim-treesitter.configs.
-- setup() only accepts { install_dir = "..." }; everything else is Neovim builtins.
require("nvim-treesitter").setup({})

-- Install parsers (async, no-op if already installed)
-- require("nvim-treesitter").install({
--   "bash",
--   "css",
--   "html",
--   "javascript",
--   "python",
--   "svelte",
--   "tsx",
--   "typescript",
--   "vue",
--   "groovy",
-- })

-- Highlighting: Neovim builtin, enabled via FileType autocmd
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start) -- silently skip filetypes without a parser
  end,
})

-- Indentation: nvim-treesitter provides indentexpr()
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(function()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end)
  end,
})

-- Textobjects: keymaps for nvim-treesitter-textobjects (af/if = function, ab/ib = block, as/is = statement)
local textobj_maps = {
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ab"] = "@block.outer",
  ["ib"] = "@block.inner",
  ["as"] = "@statement.outer",
  ["is"] = "@statement.inner",
}
for lhs, capture in pairs(textobj_maps) do
  vim.keymap.set({ "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
  end, { desc = "TS textobject: " .. capture })
end

-- Write mode
require("autolist").setup()
vim.keymap.set("n", "<leader><tab>", "<cmd>AutolistTab<cr>")
vim.keymap.set("n", "<leader><s-tab>", "<cmd>AutolistShiftTab<cr>")
vim.keymap.set("i", "<cr>", "<CR><cmd>AutolistNewBullet<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>AutolistToggleCheckbox<cr>")
-- vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
-- vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
-- vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
-- vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
require("zen-mode").setup({
  window = {
    width = 0.7,
    height = 0.7,
    options = {
      signcolumn = "no", -- disable signcolumn
      number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
    },
  },
  on_open = function(win)
    vim.opt.wrap = true
  end,
  on_close = function()
    vim.opt.wrap = false
  end,
})
vim.api.nvim_set_keymap("n", "<Leader>w", ":ZenMode<CR>", { noremap = true, silent = true, desc = "Write mode" })

-- Sticky scrolling
require("treesitter-context").setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 1, -- Maximum number of lines to show for a single context
  trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})

vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = true, sp = "Grey" })

vim.api.nvim_set_hl(0, "Normal", { ctermfg = "White", ctermbg = "Black" })
-- vim.keymap.set("n", "[c", function()
--   require("treesitter-context").go_to_context(vim.v.count1)
-- end, { silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<Leader>nc",
  ":TSContextToggle<CR>",
  { noremap = true, silent = true, desc = "Toggle sticky scroll (context)" }
)

-- Refactor
vim.keymap.set("x", "<leader>re", function()
  require("refactoring").refactor("Extract Function")
end, { desc = "Extract Function" })
vim.keymap.set("x", "<leader>rf", function()
  require("refactoring").refactor("Extract Function To File")
end, { desc = "Extract function to file" })
-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>rv", function()
  require("refactoring").refactor("Extract Variable")
end, { desc = "Extract variable" })
-- Extract variable supports only visual mode
vim.keymap.set("n", "<leader>rI", function()
  require("refactoring").refactor("Inline Function")
end, { desc = "Inline function" })
-- Inline func supports only normal
vim.keymap.set({ "n", "x" }, "<leader>ri", function()
  require("refactoring").refactor("Inline Variable")
end, { desc = "Inline variable" })
-- Inline var supports both normal and visual mode
vim.keymap.set("n", "<leader>rb", function()
  require("refactoring").refactor("Extract Block")
end, { desc = "Extract block" })
vim.keymap.set("n", "<leader>rbf", function()
  require("refactoring").refactor("Extract Block To File")
end, { desc = "Extract block to file" })
-- Extract block supports only normal mode

-- -- Leap
-- require("leap").create_default_mappings()
-- -- Define equivalence classes for brackets and quotes, in addition to
-- -- the default whitespace group.
-- require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
-- require("leap").opts.labels = "sfnjklhodweimbuyvrgtaqpcxz"

-- Setup oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Node dependent plugins
if vim.fn.executable("node") == 1 then
  -- Mason: install and manage LSP servers
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "bashls", "ts_ls", "svelte" },
  })
else
  vim.notify("Node.js not found, skipping Node-dependent config", vim.log.levels.WARN)
end

-- Better information / popups, instead of having to press "ok"
require("noice").setup({
  cmdline = {
    format = {
      cmdline = { icon = ">" },
      search_down = { icon = "⌕⌄" },
      search_up = { icon = "⌕⌃" },
      filter = { icon = "$" },
      lua = { icon = "☾" },
      help = { icon = "?" },
    },
  },
  format = {
    level = {
      icons = {
        error = "✖",
        warn = "▼",
        info = "●",
      },
    },
  },
  popupmenu = {
    kind_icons = false,
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
