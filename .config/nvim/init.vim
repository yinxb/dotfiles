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

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Git
Plug 'tpope/vim-fugitive'

" Icons, required by nvim-tree, bufferline and lualine
Plug 'kyazdani42/nvim-web-devicons'

" File explorer
Plug 'kyazdani42/nvim-tree.lua'

" Color theme that supports TreeSitter
Plug 'mhartington/oceanic-next'
Plug 'projekt0n/github-nvim-theme'

" Tabline 
Plug 'akinsho/bufferline.nvim'

" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'

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
" Plug 'folke/which-key.nvim'

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

set hidden
set nocompatible
set number 
set relativenumber
set cursorline
set nowrap
set mouse=a
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
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

filetype plugin indent on

if (has("termguicolors"))
  set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext

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


" ==========================LSP================================================
" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
-- require('rust-tools').setup({})
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
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

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting()

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
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
})
EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <space> rn     <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <space> f       <cmd>lua vim.lsp.buf.formatting()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" lua << EOF
" require("which-key").setup {
"    -- your configuration comes here
"    -- or leave it empty to use the default settings
"    -- refer to the configuration section below
" }
" EOF

" Nvim-tree
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
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
    }
  }
}
EOF

lua << EOF
require('lualine').setup {
  options = {
    -- theme = 'OceanicNext',
    theme = 'github',
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''}
    component_separators = '',
    section_separators = '',
    -- disabled_filetypes = {'NvimTree'}
  },
  sections = {
    lualine_a = {
     {'mode', fmt = function(str) return str:sub(1,1) end}},
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_b = {{'FugitiveHead', fmt = function(str) return " " .. str end}, 'diff', {'diagnostics', sources={'nvim_lsp'}}},
    lualine_c = {'lsp_progress'},
    lualine_x = {'filename'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location','filename'},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {'nvim-tree','toggleterm','fugitive'}
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
local padding = " "
require("bufferline").setup{
  options = {
   -- numbers = "both",
   numbers = function(opts) return string.format('%s',opts.ordinal) end,
   -- tab_size = 18,
   offsets = {{
      filetype = "NvimTree",
      text = "EXPLORER", 
      highlight = "Directory",
      text_align = "center",
    }},
    -- separator_style = {"" .. padding, "" .. padding},
    separator_style = "thick",
    always_show_bufferline = false,
    -- enforce_regular_tabs = true,
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

" let g:auto_session_pre_save_cmds = ["tabdo NvimTreeClose"]
lua <<EOF
require("auto-session").setup{
  log_level = 'error',
  pre_save_cmds = {"tabdo NvimTreeClose", "tabdo ToggleTermCloseAll"}
}
EOF

" below need to be kept in the bottom
set noshowmode
set noshowcmd
set noruler

