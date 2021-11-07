call plug#begin('~/.vim/plugged')

" TreeSitter
" better to use 0.5-compat branch until neovim 0.6+ is released
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': '0.5-compat'}

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'
" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
" Show icons on the completion
Plug 'onsails/lspkind-nvim'
" See hrsh7th's other plugins for more completion sources!
" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Git
Plug 'tpope/vim-fugitive'
" Git Signs
Plug 'lewis6991/gitsigns.nvim'

" Icons, required by nvim-tree, bufferline and lualine
Plug 'kyazdani42/nvim-web-devicons'

" File explorer
Plug 'kyazdani42/nvim-tree.lua'

" Color theme that supports TreeSitter
" Plug 'mhartington/oceanic-next'
" Plug 'projekt0n/github-nvim-theme'
Plug 'Mofiqul/vscode.nvim'

" Tabline 
Plug 'akinsho/bufferline.nvim'

" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'
Plug 'SmiteshP/nvim-gps'

" Terminal
Plug 'akinsho/toggleterm.nvim'

" Sessions
Plug 'rmagatti/auto-session'
Plug 'rmagatti/session-lens'

" Cursor line, add underlines to word under the cursor
Plug 'yamatsum/nvim-cursorline'

" Add indentations
Plug 'lukas-reineke/indent-blankline.nvim'

" Register
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }

" Tags/Symbols
Plug 'simrat39/symbols-outline.nvim'

Plug 'folke/trouble.nvim'

" Comment
Plug 'numToStr/Comment.nvim'

call plug#end()

" TreeSitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"rust", "go"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

" Telescope
lua <<EOF
require("telescope").load_extension("session-lens")
EOF

" Find files using Telescope command-line sugar.
nnoremap <space>ff <cmd>Telescope find_files<cr>
nnoremap <space>fg <cmd>Telescope live_grep<cr>
nnoremap <space>fb <cmd>Telescope buffers<cr>
nnoremap <space>fh <cmd>Telescope help_tags<cr>

set hidden
set nocompatible
set number 
set relativenumber
set cursorline
set nowrap
set mouse=a
set noequalalways
" hide the ~ 
set fillchars=eob:\ ,fold:\ 
" use %y to copy text to clipboard
set clipboard=unnamed

" fold by expr provided by TreeSitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable "disable fold when open file when opening
set foldlevel=99

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
" set completeopt=menuone,noinsert,noselect
set completeopt=menu,menuone,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

filetype plugin indent on

if (has("termguicolors"))
  set termguicolors
endif

" Theme
syntax enable
" colorscheme OceanicNext
let g:vscode_style = "dark"
colorscheme vscode

" nmap <space>1 :1b<CR>
" nmap <space>2 :2b<CR>
" nmap <space>3 :3b<CR>
" nmap <space>4 :4b<CR>
" nmap <space>5 :5b<CR>
" nmap <space>6 :6b<CR>
" nmap <space>7 :7b<CR>
" nmap <space>8 :8b<CR>
" nmap <space>9 :9b<CR>
nmap <space>- :bprevious!<CR>
nmap <space>+ :bnext!<CR>
nmap <space>= :bnext!<CR>

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
local lspkind = require('lspkind')
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
   })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
  formatting = {
    format = lspkind.cmp_format({with_text = true, maxwidth = 50})
    }
})
EOF

" ==========================LSP================================================
" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
	runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },
        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },	
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,	    
            highlight = "Comment",	    
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
	capabilities = capabilities,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)

" Disable nvim-cmp on the TelescopePrompt buffer
autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }

" LSP Mapping ====================================================================
" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <F2>  <cmd>lua vim.lsp.buf.rename()<CR>
" ================================================================================

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
" set signcolumn=yes

" Nvim-tree
let g:nvim_tree_gitignore = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf',
    \     'Outline'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "",
    \   'staged': "S",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "U",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }
nnoremap <C-n> :NvimTreeToggle<CR>
lua << EOF
require'nvim-tree'.setup {
    -- disables netrw completely
    disable_netrw  = true,
    hijack_netrw   = true,
    open_on_setup  = false,
    view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- Hide the root path of the current folder on top of the tree 
    hide_root_folder = false,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    },
    filters = {
     dotfiles = true,
     custom = {'.git'}
    }
  }
}
EOF

lua <<EOF
require("nvim-gps").setup({
	icons = {
		["class-name"] = ' ',      -- Classes and class-like objects
		["function-name"] = ' ',   -- Functions
		--["function-name"] = ' ',   -- Functions
		["method-name"] = ' ',     -- Methods (functions inside class-like objects)
		["container-name"] = '⛶ ',  -- Containers (example: lua tables)
		["tag-name"] = '炙'         -- Tags (example: html tags)
	},
	-- Add custom configuration per language or
	-- Disable the plugin for a language
	-- Any language not disabled here is enabled by default
	languages = {
		-- ["bash"] = false, -- disables nvim-gps for bash
		-- ["go"] = false,   -- disables nvim-gps for golang
		-- ["ruby"] = {
		--	separator = '|', -- Overrides default separator with '|'
		--	icons = {
		--		-- Default icons not specified in the lang config
		--		-- will fallback to the default value
		--		-- "container-name" will fallback to default because it's not set
		--		["function-name"] = '',    -- to ensure empty values, set an empty string
		--		["tag-name"] = ''
		--		["class-name"] = '::',
		--		["method-name"] = '#',
		--	}
		--}
	},
	separator = '',
	-- limit for amount of context shown
	-- 0 means no limit
	-- Note: to make use of depth feature properly, make sure your separator isn't something that can appear
	-- in context names (eg: function names, class names, etc)
	depth = 0,
	-- indicator used when context is hits depth limit
	depth_limit_indicator = ".."
	}
)
EOF

lua << EOF

local function custom_location()
--	return [[Ln %l,Col %c]]
	return [[Col %c]]
end

local colors = {
  black        = "#262626",
  white        = '#ffffff',
  red          = '#f44747',
  green        = '#619955',
  blue         = '#0a7aca',
  lightblue    = '#5CB6F8',
  yellow       = '#ffaf00',
  purple       = '#68217a',
}


local codedark = {
	normal = {
	  b = {fg = colors.white, bg = colors.blue},
	  a = {fg = colors.white, bg = colors.blue},
	  c = {fg = colors.white, bg = colors.blue},
	},
	visual = {
	  b = {fg = colors.white, bg = colors.green},
	  a = {fg = colors.white, bg = colors.green},
	  c = {fg = colors.white, bg = colors.green},
	},
	inactive = {
	  b = {fg = colors.white, bg = colors.gray},
	  a = {fg = colors.white, bg = colors.gray},
	  c = {fg = colors.white, bg = colors.gray},
	},
	replace = {
	  b = {fg = colors.yellow, bg = colors.black},
	  a = {fg = colors.black, bg = colors.yellow},
	  c = {fg = colors.white, bg = colors.black}
	},
	insert = {
	  a = {fg = colors.black, bg = colors.yellow},
	  b = {fg = colors.black, bg = colors.yellow},
	  c = {fg = colors.black, bg = colors.yellow},
	},
	command = {
	  a = {fg = colors.white, bg = colors.purple},
	  b = {fg = colors.white, bg = colors.purple},
	  c = {fg = colors.white, bg = colors.purple},
	}
}

--[===[
local treesitter = require('nvim-treesitter')
local function treelocation()
  return treesitter.statusline({
    indicator_size = 70,
    type_patterns = {'class', 'function', 'method'},
    separator = ' -> '
  })
end
--]===]

local gps = require("nvim-gps")

local sections = {
    -- lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end}},
    -- other icons:  ﯎  
    --lualine_a = {{'mode', fmt = function(str) if str == "NORMAL" then return "" elseif str == "INSERT" then return "" elseif str == "VISUAL" or str == "V-LINE" or str == "V-BLOCK" then return "﯎" elseif str == "COMMAND" then return "" else return str end end}},
    lualine_a = {},
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_b = {{'FugitiveHead', fmt = function(str) if str == "" then return "" else return " " .. str end end}, 'diff', {'diagnostics', sources={'nvim_lsp'}}},
    lualine_c = {'lsp_progress'},
    lualine_x = {{'filename', path = 1, fmt= function(str) return str:gsub("/","") end, padding = { right = right_padding}},{ gps.get_location, cond = gps.is_available, fmt = function(str) if str == "" then return "" else return ""..str end end, padding = {left = 0} }},
    lualine_y = {},
    --lualine_y = {treelocation},
    lualine_z = {custom_location},
}

-- don't add lsp_progress into inactive_sections
-- https://github.com/arkav/lualine-lsp-progress/issues/5
local inactive_sections = {
    lualine_a = {},
    lualine_b = {{'FugitiveHead', fmt = function(str) if str == "" then return "" else return " " .. str end end}, 'diff', {'diagnostics', sources={'nvim_lsp'}}},
    lualine_c = {},
    lualine_x = {{'filename', path = 1}},
    lualine_y = {},
    lualine_z = {},
}

require('lualine').setup {
  options = {
    -- theme = 'OceanicNext',
    -- theme = 'vscode',
    theme = codedark,
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''}
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {'Outline','NvimTree', 'ToggleTerm'}
  },
  sections = sections,
  inactive_sections = inactive_sections, 
  -- extensions = {'nvim-tree','toggleterm','fugitive'},
}
EOF

nnoremap <silent><space>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><space>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><space>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><space>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><space>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><space>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><space>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><space>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><space>9 <Cmd>BufferLineGoToBuffer 9<CR>
lua << EOF
require("bufferline").setup{
  options = {
	  -- ﱤ ﳗ                ⭘ וּ ﰬ  ﲗ ﲔ ﲕ ﲖ  ﰲ   龎  﫜      ﳂ    ﯎       ﮋ   
   -- indicator_icon = 'ﰲ ',
   -- numbers = "both",
   numbers = function(opts) return string.format('%s',opts.ordinal) end,
   offsets = {{
      filetype = "NvimTree",
      text = " EXPLORER", 
      highlight = "Directory",
      text_align = "left",
    }},
    -- separator_style = "slant",
    -- always_show_bufferline = false,
    -- enforce_regular_tabs = true,
    show_buffer_icons = true,
    show_close_icon = false,
  },
 }
EOF

lua <<EOF
-- require("github-theme").setup({
--  theme_style = "auto",
-- })
EOF

lua <<EOF
require("toggleterm").setup{
  open_mapping = [[<c-\>]],
  direction = 'float',
  float_opts = {
    border = 'double',
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}
EOF

lua <<EOF
require("auto-session").setup{
  log_level = 'error',
  pre_save_cmds = {"tabdo NvimTreeClose", "tabdo ToggleTermCloseAll", "tabdo SymbolsOutlineClose"}
}
EOF

lua <<EOF
require('gitsigns').setup()
EOF

"autocmd FileType Outline set nobuflisted
"autocmd BufEnter OUTLINE setlocal nobuflisted 
lua <<EOF
vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = 'right',
    width = 25,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = {"<Esc>", "q"},
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
        File = {icon = "", hl = "TSURI"},
        --Module = {icon = "", hl = "TSNamespace"},
	Module = {icon = "{}", hl = "TSNamespace"},
        Namespace = {icon = "", hl = "TSNamespace"},
        Package = {icon = "", hl = "TSNamespace"},
        --Class = {icon = "𝓒", hl = "TSType"},
        Class = {icon = "", hl = "TSType"},
        Method = {icon = "ƒ", hl = "TSMethod"},
        Property = {icon = "", hl = "TSMethod"},
        Field = {icon = "", hl = "TSField"},
        Constructor = {icon = "", hl = "TSConstructor"},
        Enum = {icon = "ℰ", hl = "TSType"},
        Interface = {icon = "ﰮ", hl = "TSType"},
        --Function = {icon = "", hl = "TSFunction"},
        Function = {icon = "", hl = "TSFunction"},
        Variable = {icon = "", hl = "TSConstant"},
        Constant = {icon = "", hl = "TSConstant"},
        String = {icon = "𝓐", hl = "TSString"},
        Number = {icon = "#", hl = "TSNumber"},
        Boolean = {icon = "⊨", hl = "TSBoolean"},
        Array = {icon = "", hl = "TSConstant"},
        -- Object = {icon = "⦿", hl = "TSType"},
	Object = {icon = "{}", hl = "TSType"},
        Key = {icon = "", hl = "TSType"},
        Null = {icon = "NULL", hl = "TSType"},
        EnumMember = {icon = "", hl = "TSField"},
        --Struct = {icon = "𝓢", hl = "TSType"},
        Struct = {icon = "", hl = "TSType"},
        Event = {icon = "🗲", hl = "TSType"},
        Operator = {icon = "+", hl = "TSOperator"},
        TypeParameter = {icon = "𝙏", hl = "TSParameter"}
    }
}
EOF

" Vim Script
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

lua <<EOF
require('Comment').setup()
EOF
" below need to be kept in the bottom
set noshowmode
set noshowcmd
set noruler

