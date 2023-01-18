
-- More like IDE
require('lspconfig').pyright.setup{}
require('lspconfig').bashls.setup{}
require('lspconfig').tsserver.setup({})
require('lspconfig').svelte.setup{}

require('nvim-autopairs').setup{}
require("which-key").setup{}

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
    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    local commentstr = require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    }
    return commentstr
  end,
}

-- docstring
-- generate docstring
require('neogen').setup()
vim.api.nvim_set_keymap("n", "<Leader>nd", ":lua require('neogen').generate()<CR>", {noremap=true, silent=true, desc="Generate docstring"})

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
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
    -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
    -- ensure_installed can be "all" or a list of languages { "python", "javascript" }
    -- ensure_installed = "maintained",
    ensure_installed = {
        "bash",
        "css",
        "html",
        "javascript",
        "python",
        "tsx",
        "typescript",
        "vue",
        "svelte",
    },

    highlight = { -- enable highlighting for all file types
      -- enable = true,
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
vim.api.nvim_set_keymap("n", "<Leader>w", ":lua require('zen-mode').toggle()<CR>", {noremap=true, silent=true, desc="Generate docstring"})
