return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {
        	'nvim-treesitter/nvim-treesitter',
        	run = ':TSUpdate'
    	}


	use {
		'nvim-telescope/telescope.nvim',
  		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use 'neovim/nvim-lspconfig'

	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip-integ',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'onsails/lspkind-nvim',
			'hrsh7th/vim-vsnip'
		}
	}

	use {
		'simrat39/rust-tools.nvim',
		requires = {{'nvim-lua/popup.nvim'}}
	}


 	use 'tpope/vim-fugitive'
	use {
                'lewis6991/gitsigns.nvim',
                requires = {'nvim-lua/popup.nvim'},
                config = function()
                        require('gitsigns').setup()
                end
        }

	use {
                'kyazdani42/nvim-tree.lua',
                requires = {
                        'kyazdani42/nvim-web-devicons'
                }
        }

	use {
                'akinsho/bufferline.nvim',
                requires = {
                        'kyazdani42/nvim-web-devicons'
                }
        }

	use {
               'nvim-lualine/lualine.nvim',
                requires = {
                        'kyazdani42/nvim-web-devicons'
                }
        }

        use 'arkav/lualine-lsp-progress'
        use 'SmiteshP/nvim-gps'

	use 'akinsho/toggleterm.nvim'

	use 'rmagatti/auto-session'
	use 'rmagatti/session-lens'

	-- Cursor line, add underlines to word under the cursor
	use 'yamatsum/nvim-cursorline'

	-- Add indentations
	use 'lukas-reineke/indent-blankline.nvim'

	-- Register
	use 'tversteeg/registers.nvim'

	-- Tags/Symbols
	use 'simrat39/symbols-outline.nvim'

	use 'folke/trouble.nvim'

	use {
                'numToStr/Comment.nvim',
                config = function()
                        require('Comment').setup()
                end
        }
	use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'
	use 'leoluz/nvim-dap-go'

 	use 'Mofiqul/vscode.nvim'

end)
