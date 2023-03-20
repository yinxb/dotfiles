require("keymaps")
require("telescope").load_extension("session-lens")

require("telescope").setup {
        pickers = {
                buffers = {
                        ignore_current_buffer = true,
                        sort_lastused = true,
                },
        }
}


nmap('<space>ff', [[<cmd>Telescope find_files<cr>]])
nmap('<space>fg', [[<cmd>Telescope live_grep<cr>]])
nmap('<space>fb', [[<cmd>Telescope buffers<cr>]])
nmap('<space>fh', [[<cmd>Telescope help_tags<cr>]])
nmap('<space>fo', [[<cmd>Telescope oldfiles<cr>]])
nmap('<space>fj', [[<cmd>Telescope jumplist<cr>]])


vim.cmd([[autocmd! FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }]])
