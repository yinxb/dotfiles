local opt = vim.opt

-- True color
opt.termguicolors = true

-- Completion
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
opt.completeopt = {'menu','menuone', 'noselect'}  -- set completeopt=menu,menuone,noselect
opt.shortmess = opt.shortmess + 'c'
opt.updatetime = 300

-- Enable background buffers
opt.hidden = true

opt.number = true
opt.relativenumber = true

-- Search
opt.hlsearch = true
-- Starts seaching as soon as typing
opt.incsearch = true 
opt.ignorecase = true
-- Do not ignore case with capitals
opt.smartcase = true

-- Insert indents automatically
opt.autoindent = true
opt.smartindent = true
-- Use spaces instead of tab
opt.expandtab = true 

opt.wrap = false 

opt.cursorline = true 

-- Enable mouse
opt.mouse = "a" -- set mouse=a

-- Put new windows below current
opt.splitbelow = true 
-- Put new windows right of current
opt.splitright = true 

-- Command-line Completion mode
-- opt.wildmode = {'list', 'longest'} 

-- opt.swapfile = false -- Disable swap will cause auto session not working

-- vim.wo.singcolumn = "yes"

-- opt.compatible = false
opt.equalalways = false


opt.clipboard = "unnamed"


opt.diffopt = opt.diffopt + "algorithm:histogram"

-- Fold by expr provided by TreeSitter
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
-- Disable fold when open file when opening
opt.foldenable = false 
opt.foldlevel = 99

-- Persistent undo
opt.undofile = true
vim.bo.undofile = true 

-- Spell check
opt.spelllang = "en"
-- Show 10 spell checking candidates at most
opt.spellsuggest = "best,10"


opt.showmode = false
opt.showcmd = false
opt.ruler = false


