local function custom_location()
	return [[Col:%c]]
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
    lualine_a = {},
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_b = {{'FugitiveHead', fmt = function(str) if str == "" then return "" else return " " .. str end end}, 'diff', {'diagnostics', sources={'nvim_diagnostic'}}},
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
    lualine_b = {{'FugitiveHead', fmt = function(str) if str == "" then return "" else return " " .. str end end}, 'diff', {'diagnostics', sources={'nvim_diagnostic'}}},
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
    disabled_filetypes = {'Outline','NvimTree', 'ToggleTerm', 'Trouble', 'dapui_watches', 'dapui_stacks', 'dapui_breakpoints', 'dapui_scopes', 'dap-repl'}
  },
  sections = sections,
  inactive_sections = inactive_sections, 
  -- extensions = {'nvim-tree','toggleterm','fugitive'},
}

