require('keymaps')

require("trouble").setup {}

nmap('<leader>xx', '<cmd>TroubleToggle<cr>')
nmap('<leader>gw', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>')
nmap('<leader>gd', '<cmd>TroubleToggle lsp_document_diagnostics<cr>')
nmap('<leader>gq', '<cmd>TroubleToggle quickfix<cr>')
nmap('<leader>gl', '<cmd>TroubleToggle loclist<cr>')
nmap('gr', '<cmd>TroubleToggle lsp_references<cr>')

