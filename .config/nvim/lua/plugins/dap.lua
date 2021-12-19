require('keymaps')

require('dap-go').setup()
require("dapui").setup()

nmap('<F9>', [[:lua require'dap'.continue()<cr>]])
nmap('<F8>', [[:lua require'dap'.step_over()<cr>]])
nmap('<F7>', [[:lua require'dap'.step_into()<cr>]])
nmap('<F12>', [[:lua require'dap'.step_out()<cr>]])
nmap('<leader>b', [[:lua require'dap'.toggle_breakpoint()<cr>]])
nmap('<leader>B', [[:lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>]])
nmap('<leader>lp', [[:lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>]])
nmap('<leader>dr', [[:lua require'dap'.repl.open()<cr>]])
nmap('<leader>dl', [[:lua require'dap'.run_last()<cr>]])



