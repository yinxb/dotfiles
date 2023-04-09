vim.g.barbar_auto_setup = false -- disable auto-setup
require'barbar'.setup {
 icons = {
    buffer_index = true,
  },
  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = nil}
    NvimTree = true,
    Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
  },
  insert_at_end = true,
}



nmap('<space>1', '<Cmd>BufferGoto 1<cr>')
nmap('<space>2', '<Cmd>BufferGoto 2<cr>')
nmap('<space>3', '<Cmd>BufferGoto 3<cr>')
nmap('<space>4', '<Cmd>BufferGoto 4<cr>')
nmap('<space>5', '<Cmd>BufferGoto 5<cr>')
nmap('<space>6', '<Cmd>BufferGoto 6<cr>')
nmap('<space>7', '<Cmd>BufferGoto 7<cr>')
nmap('<space>8', '<Cmd>BufferGoto 8<cr>')
nmap('<space>9', '<Cmd>BufferGoto 9<cr>')


