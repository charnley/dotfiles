return require('packer').startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

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
    use 'APZelos/blamer.nvim' -- Git blame line

    -- Svelte development
    use 'JoosepAlviste/nvim-ts-context-commentstring' -- For context comment
    use 'evanleck/vim-svelte'
    use 'pangloss/vim-javascript'
    use 'HerringtonDarkholme/yats.vim'

    -- Write mode
    use "folke/zen-mode.nvim"

end)
