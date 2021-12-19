require('keymaps')

-- vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_window_picker_exclude = {
	['filetype'] = {
         'notify',
         'packer',
         'qf',
         'Outline',
         'Trouble',
 	},
	['buftype'] = {
         'terminal'
 	}
}
vim.g.nvim_tree_show_icons = {
	['git'] = 1,
	['folders'] = 1,
	['files'] = 1,
	['folder_arrows'] = 1,
}
vim.g.nvim_tree_icons = {
	['default'] = '',
	['symlink'] = '',
        ['git'] = {
       		['unstaged'] = "",
       		['staged'] = "S",
       		['unmerged'] = "",
       		['renamed'] = "➜",
       		['untracked'] = "U",
       		['deleted'] = "",
       		['ignored'] = "◌"
       	},
     	['folder'] = {
       		['arrow_open'] = "",
       		['arrow_closed'] = "",
       		['default'] = "",
       		['open'] = "",
       		['empty'] = "",
       		['empty_open'] = "",
       		['symlink'] = "",
       		['symlink_open'] = "",
       	}
}


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
        dotfiles = false,
        custom = { ".git", ".DS_Store", ".idea" }
    },
    git = {
        enable = true,
        ignore = true,
    },
    filters = {
     dotfiles = true,
     custom = {'.git'}
    }
  }
}

nmap('<c-n>', ':NvimTreeToggle<cr>')
