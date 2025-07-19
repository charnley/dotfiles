local plugins = {

	-- General
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{ "junegunn/fzf.vim" },

	-- Motion
	{ "chaoren/vim-wordmotion" }, -- Better word motion
	{ "MattesGroeger/vim-bookmarks" }, -- Easy bookmark shortcuts
	{ "ggandor/leap.nvim" },

	-- Visual / Interface
	{ "rebelot/kanagawa.nvim" }, -- colorscheme
	{ "ojroques/nvim-hardline" },
	{ "folke/which-key.nvim" }, -- I can't remember what <leader><char> does

	-- IDE
	{ "danymat/neogen" }, -- generate docstrings (with treesitter)
	{ "kkoomen/vim-doge" }, -- Generate docstrings, :call doge#install()
	{ "gorkunov/smartpairs.vim" }, -- Extend visual selection of bracket
	{ "kabouzeid/nvim-lspinstall" },
	{ "neovim/nvim-lspconfig" },
	{ "numToStr/Comment.nvim" }, -- For Commenting gcc & gc (Treesitter support)
	{ "nvim-lua/plenary.nvim" }, -- "all the lua function I don't want to write twice"
	{ "nvim-treesitter/nvim-treesitter" }, -- build=':TSUpdate'
	{ "nvim-treesitter/nvim-treesitter-context" }, -- Sticky scrolling
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "nvim-treesitter/playground" },
	{ "ray-x/lsp_signature.nvim", event = "InsertEnter" },
	{ "windwp/nvim-autopairs" },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
	},

	-- autocompletion
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/vim-vsnip" },

	-- snippets
	{ "rafamadriz/friendly-snippets" },

	-- github copilot
	-- :Copilot auth
	{ "zbirenbaum/copilot.lua", cmd = "Copilot", event = "InsertEnter" },
	{ "zbirenbaum/copilot-cmp" }, -- cmp auto completion

	-- Git
	{ "airblade/vim-gitgutter" }, -- Git indication
	{ "apzelos/blamer.nvim" }, -- Git blame line
	-- use 'lewis6991/gitsigns.nvim' TODO Try it out

	-- Svelte development
	{ "JoosepAlviste/nvim-ts-context-commentstring" }, -- for context-based comment
	{ "evanleck/vim-svelte" },
	{ "pangloss/vim-javascript" },
	{ "herringtondarkholme/yats.vim" },

	-- Write mode
	{ "folke/zen-mode.nvim" },
	{ "gaodean/autolist.nvim" },

	-- Files
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},
}

require("lazy").setup(plugins, {})
