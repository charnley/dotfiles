
-- More like IDE
require('lspconfig').pyright.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').tsserver.setup({})
require('lspconfig').svelte.setup({})

require('nvim-autopairs').setup({})
require("which-key").setup({})

-- Be able to comment html and js in same file
require('ts_context_commentstring').setup({})

-- Auto signature hints
require('lsp_signature').setup({

    handler_opts = {
        border = "single",   -- double, rounded, single, shadow, none
    },
    hint_prefix = "",  -- Panda for parameter

})

-- locals
local lsp = vim.lsp
local handlers = lsp.handlers
local cmp = require'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

-- add brackets after auto-complete
cmp.event:on( 'confirm_done',
    cmp_autopairs.on_confirm_done({  map_char = { tex = '' } })
)

-- comment
require("Comment").setup {
  ignore = "^$",
  pre_hook = function(ctx)
    local U = require 'Comment.utils'

    local location = nil
    if ctx.ctype == U.ctype.blockwise then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    local commentstr = require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == U.ctype.linewise and '__default' or '__multiline',
      location = location,
    }
    return commentstr
  end,
}

local ft = require('Comment.ft')
ft.set('fortran', '!%s')

-- docstring
-- generate docstring
require('neogen').setup({
    languages = {
        -- TODO This does not work, super annoying
        ['svelte'] = require('neogen.configurations.javascript')
    }
})
vim.api.nvim_set_keymap("n", "<Leader>nd", ":lua require('neogen').generate()<CR>", {noremap=true, silent=true, desc="Generate docstring"})

-- Doge
-- Open nvim and run :call doge#install()
-- vim.keymap.set('n', '<Leader>nd', '<Plug>(doge-generate)')

-- setup completion
cmp.setup({
    snippet = {
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    }, -- end snippet
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<leader>'] = cmp.mapping({ -- quickly cancel when I want the menu gone
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
        }), {'i', 'c'}),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select
        }), {'i', 'c'}),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },  -- end mapping
    sources = cmp.config.sources({
        { name = 'copilot', group_index=2},
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'vsnip' },
    }, {
        -- I don't need completion on text, especially not for small words
        { name = 'buffer', keyword_length = 6 },
    }),  -- end sources
    experimental = {
        ghost_text = true,  -- write out the auto completetion
    }
})

-- lsp setup
-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "!",
      spacing = 2,
    },
    signs = true,
    underline = true,
  }
)

--- Treesitter
require('nvim-treesitter.install').compilers = { "clang", "gcc" }
require'nvim-treesitter.configs'.setup {
    -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
    -- ensure_installed can be "all" or a list of languages { "python", "javascript" }
    -- ensure_installed = "maintained",
    ensure_installed = {
        "bash",
        "css",
        "html",
        "javascript",
        "python",
        "svelte",
        "tsx",
        "typescript",
        "vue",
    },

    highlight = { -- enable highlighting for all file types
      enable = true,
    },

    -- need for proper indentation handling (especially for bracket pairs)
    indent = {
      enable = true
    },

    incremental_selection = {
      enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
      disable = { "cpp", "lua" },
      keymaps = {                       -- mappings for incremental selection (visual mappings)
        init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
        node_incremental = "grn",       -- increment to the upper named parent
        scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "grm",       -- decrement to the previous node
      }
    },

    textobjects = {
      -- These are provided by
      select = {
        enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
        keymaps = {
          -- You can use the capture groups defined here:
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/c/textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["as"] = "@statement.outer",
          ["is"] = "@statement.inner",
        },
      },
    },
}

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
require("zen-mode").setup{
    window = {
        width = 0.5,
        height = 0.5,
        options = {
            signcolumn = "no", -- disable signcolumn
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
        },
    },
  on_open = function(win)
    vim.api.nvim_exec([[set wrap]], false)
  end,
  on_close = function()
    vim.api.nvim_exec([[set nowrap]], false)
  end,
}
vim.api.nvim_set_keymap("n", "<Leader>w", ":ZenMode<CR>", {noremap=true, silent=true, desc="Write mode"})

-- Sticky scrolling
require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 1, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

vim.api.nvim_exec([[
hi TreesitterContextBottom gui=underline guisp=Grey
hi TreesitterContextLineNumberBottom gui=underline guisp=Grey
hi TreesitterContextLineNumberBottom gui=underline guisp=Grey
]], false)

vim.api.nvim_set_hl(0, "Normal", { ctermfg=White,  ctermbg=Black })
-- vim.keymap.set("n", "[c", function()
--   require("treesitter-context").go_to_context(vim.v.count1)
-- end, { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>nc", ":TSContextToggle<CR>", {noremap=true, silent=true, desc="Toggle sticky scroll (context)"})


require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}


-- Refactor
vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end, {desc="Extract Function"})
vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end, {desc="Extract function to file"})
-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end, {desc="Extract variable"})
-- Extract variable supports only visual mode
vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end, {desc="Inline function"})
-- Inline func supports only normal
vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, {desc="Inline variable"})
-- Inline var supports both normal and visual mode
vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end, {desc="Extract block"})
vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end, {desc="Extract block to file"})
-- Extract block supports only normal mode


-- Leap
require('leap').create_default_mappings()
-- Define equivalence classes for brackets and quotes, in addition to
-- the default whitespace group.
require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
require('leap').opts.labels = 'sfnjklhodweimbuyvrgtaqpcxz'

-- Setup oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
