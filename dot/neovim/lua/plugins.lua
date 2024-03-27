local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

    -- General
    {'junegunn/fzf.vim'},

    -- Motion
    {'chaoren/vim-wordmotion'}, -- Better word motion
    {'MattesGroeger/vim-bookmarks'},  -- Easy bookmark shortcuts
    {'ggandor/leap.nvim'},

    -- Visual / Interface
    {'rebelot/kanagawa.nvim'}, -- colorscheme
    {'ojroques/nvim-hardline'},
    {'folke/which-key.nvim'},  -- I can't remember what <leader><char> does

    -- IDE
    {'numToStr/Comment.nvim'}, -- For Commenting gcc & gc (Treesitter support)
    {'gorkunov/smartpairs.vim'}, -- Extend visual selection of bracket
    {'windwp/nvim-autopairs'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-vsnip'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/vim-vsnip'},
    {'kabouzeid/nvim-lspinstall'},
    {'neovim/nvim-lspconfig'},
    {'nvim-treesitter/nvim-treesitter'}, -- build=':TSUpdate'
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    {'nvim-treesitter/playground'},
    {'rafamadriz/friendly-snippets'},
    {'ray-x/lsp_signature.nvim'},  --  https://github.com/ray-x/lsp_signature.nvim
    {'danymat/neogen'},  -- generate docstrings (with treesitter)
    {'ThePrimeagen/refactoring.nvim'}, -- refactor chunks of code fast
    {'nvim-lua/plenary.nvim'}, -- "all the lua function I don't want to write twice"
    {'nvim-treesitter/nvim-treesitter-context'}, -- Sticky scrolling

    -- github copilot
    -- :Copilot auth
    {
          "zbirenbaum/copilot.lua",
          cmd = "Copilot",
          event = "InsertEnter",
    },
    {"zbirenbaum/copilot-cmp",},

    -- Git
    {'airblade/vim-gitgutter'}, -- Git indication
    {'apzelos/blamer.nvim'}, -- Git blame line
    -- use 'lewis6991/gitsigns.nvim' TODO Try it out

    -- Svelte development
    {'JoosepAlviste/nvim-ts-context-commentstring'}, -- for context-based comment
    {'evanleck/vim-svelte'},
    {'pangloss/vim-javascript'},
    {'herringtondarkholme/yats.vim'},

    -- Write mode
    {'folke/zen-mode.nvim'},
    {'gaodean/autolist.nvim'},

}

require('lazy').setup(plugins, {})
