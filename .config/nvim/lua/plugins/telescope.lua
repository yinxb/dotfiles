require("keymaps")
require("telescope").load_extension("session-lens")


nmap('<space>ff', [[<cmd>Telescope find_files<cr>]])
nmap('<space>fg', [[<cmd>Telescope live_grep<cr>]])
nmap('<space>fb', [[<cmd>Telescope buffers<cr>]])
nmap('<space>fh', [[<cmd>Telescope help_tags<cr>]])


vim.cmd([[autocmd! FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }]])
