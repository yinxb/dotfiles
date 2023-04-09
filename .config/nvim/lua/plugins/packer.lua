return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {
        	'nvim-treesitter/nvim-treesitter',
        	run = ':TSUpdate'
    	}

 	use  'Mofiqul/vscode.nvim'
        

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
                'romgrk/barbar.nvim', 
                requires = 'nvim-web-devicons'
        }

	-- use {
 --                'akinsho/bufferline.nvim', branch = 'main',
 --                requires = {
 --                        'kyazdani42/nvim-web-devicons'
 --                }
 --        }

	use {
               'nvim-lualine/lualine.nvim',
                requires = {
                        'kyazdani42/nvim-web-devicons'
                }
        }

        use 'arkav/lualine-lsp-progress'
        use {
                "SmiteshP/nvim-navic",
                requires = "neovim/nvim-lspconfig"
        }

	use {
                'akinsho/toggleterm.nvim', branch = 'main',
        }

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
        use({
          "folke/noice.nvim",
          config = function()
            require("noice").setup()
          end,
          requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
            }
        })
	use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'
	use 'leoluz/nvim-dap-go'


        -- use({
        --         'projekt0n/github-nvim-theme', tag = 'v0.0.7',
        --         config = function()
        --                 require('github-theme').setup({
        --                         -- ...
        --                 })
        --         end
        -- })

end)
