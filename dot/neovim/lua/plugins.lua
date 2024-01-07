-- require("lazy").setup({
--   "folke/which-key.nvim",
--   'dstein64/vim-startuptime',
--  
--   'MattesGroeger/vim-bookmarks',  -- Easy bookmark shortcuts
--   'ap/vim-css-color',  -- Preview CSS Colors
--   'chaoren/vim-wordmotion', -- Better word motion
--   'justinmk/vim-sneak'  -- Jump to char
--   {'junegunn/fzf', run= './install --all'},  -- Fuzzy find searching
--   'junegunn/fzf.vim',  -- Fuzzy find searching
--   'numToStr/Comment.nvim', -- For Commenting gcc & gc (Treesitter support)
--   'gorkunov/smartpairs.vim', -- Extend visual selection of bracket

--    -- Interface
--    'nanotech/jellybeans.vim', -- colorscheme
--    'vim-airline/vim-airline',
--    'vim-airline/vim-airline-themes',
--    'folke/which-key.nvim',  -- I can't remember what <leader><char> does

--    -- IDE like
--    'windwp/nvim-autopairs',
--    'hrsh7th/cmp-buffer',
--    'hrsh7th/cmp-nvim-lsp',
--    'hrsh7th/cmp-path',
--    'hrsh7th/cmp-vsnip',
--    'hrsh7th/nvim-cmp',
--    'hrsh7th/vim-vsnip',
--    'kabouzeid/nvim-lspinstall',
--    'neovim/nvim-lspconfig',
--    {'nvim-treesitter/nvim-t,reesitter', run= ':TSUpdate'},
--    'nvim-treesitter/nvim-treesitter-textobjects',
--    'rafamadriz/friendly-snippets',
--    'ray-x/lsp_signature.nvim',  --  https://github.com/ray-x/lsp_signature.nvim
--    'danymat/neogen',  -- generate docstrings (with treesitter)

--    'airblade/vim-gitgutter', -- Git indication
--    'apzelos/blamer.nvim', -- Git blame line

--    -- Svelte development
--    'joosepalviste/nvim-ts-context-commentstring', -- for context comment
--    'evanleck/vim-svelte',
--    'pangloss/vim-javascript',
--    'herringtondarkholme/yats.vim',

--    -- Write mode
--    'folke/zen-mode.nvim',
--    'gaodean/autolist.nvim',
-- })



return require('packer').startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Admin
    use 'dstein64/vim-startuptime'

    use 'MattesGroeger/vim-bookmarks'  -- Easy bookmark shortcuts
    use 'ap/vim-css-color'  -- Preview CSS Colors
    use 'chaoren/vim-wordmotion' -- Better word motion
    use 'justinmk/vim-sneak'  -- Jump to char
    use {'junegunn/fzf', run= './install --all'}  -- Fuzzy find searching
    use 'junegunn/fzf.vim'  -- Fuzzy find searching
    use 'numToStr/Comment.nvim' -- For Commenting gcc & gc (Treesitter support)
    use 'gorkunov/smartpairs.vim' -- Extend visual selection of bracket

    -- Interface
    use 'nanotech/jellybeans.vim' -- colorscheme
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'folke/which-key.nvim'  -- I can't remember what <leader><char> does

    -- IDE like
    use 'windwp/nvim-autopairs'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'kabouzeid/nvim-lspinstall'
    use 'neovim/nvim-lspconfig'
    use {'nvim-treesitter/nvim-treesitter', run= ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'rafamadriz/friendly-snippets'
    use 'ray-x/lsp_signature.nvim'  --  https://github.com/ray-x/lsp_signature.nvim
    use 'danymat/neogen'  -- generate docstrings (with treesitter)

    use 'airblade/vim-gitgutter' -- Git indication
    use 'apzelos/blamer.nvim' -- Git blame line

    -- Svelte development
    use 'joosepalviste/nvim-ts-context-commentstring' -- for context comment
    use 'evanleck/vim-svelte'
    use 'pangloss/vim-javascript'
    use 'herringtondarkholme/yats.vim'

    -- Write mode
    use 'folke/zen-mode.nvim'
    use 'gaodean/autolist.nvim'
    -- use 'kamykn/spelunker.vim' -- Better spell checker

end)
