require('keymaps')

require'nvim-tree'.setup {
        -- disables netrw completely
        auto_reload_on_write = true,
        disable_netrw  = true,
        hijack_netrw   = true,
        open_on_setup  = false,
        view = {
                -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
                width = 30,
                -- Hide the root path of the current folder on top of the tree 
                hide_root_folder = false,
                -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
                side = 'left',
                mappings = {
                        -- custom only false will merge the list with the default mappings
                        -- if true, it will only use your list to set the mappings
                        custom_only = false,
                        -- list of mappings to set on the tree manually
                        list = {}
                },
                
        },
        renderer = {
                highlight_git = true,
                icons = {
                        glyphs = {
                                default = "",
                                symlink = "",
                                folder = {
                                  arrow_closed = "",
                                  arrow_open = "",
                                  default = "",
                                  open = "",
                                  empty = "",
                                  empty_open = "",
                                  symlink = "",
                                  symlink_open = "",
                                },
                                git = {
                                  unstaged = "",
                                  staged = "S",
                                  unmerged = "",
                                  renamed = "➜",
                                  untracked = "U",
                                  deleted = "",
                                  ignored = "◌",
                                }, 
                        }
                }
        },
        filters = {
                dotfiles = false,
                custom = { ".git", ".DS_Store", ".idea" }
        },
        git = {
                enable = true,
                ignore = true,
        },
        actions = {
                open_file = {
                        window_picker = {
                                enable = true,
                                exclude = {
                                     filetype = {'notify', 'packer', 'qf', 'diff','Outline','Trouble',},
                                     buftype = {'terminal', 'help', 'nofile',},
                                }
                        }
                }
        }
}

nmap('<c-n>', ':NvimTreeToggle<cr>')
