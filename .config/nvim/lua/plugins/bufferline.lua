require("keymaps")

require("bufferline").setup{
  options = {
   numbers = function(opts) return string.format('%s', opts.ordinal) end,
   offsets = {{
      filetype = "NvimTree",
      text = " EXPLORER", 
      highlight = "Directory",
      text_align = "left",
    }},
    separator_style = "thin",
    -- always_show_bufferline = false,
    -- enforce_regular_tabs = true,
    show_buffer_icons = false,
    show_close_icon = true,
    close_icon = 'X',
  },
 }

nmap('<space>1', '<Cmd>BufferLineGoToBuffer 1<cr>')
nmap('<space>2', '<Cmd>BufferLineGoToBuffer 2<cr>')
nmap('<space>3', '<Cmd>BufferLineGoToBuffer 3<cr>')
nmap('<space>4', '<Cmd>BufferLineGoToBuffer 4<cr>')
nmap('<space>5', '<Cmd>BufferLineGoToBuffer 5<cr>')
nmap('<space>6', '<Cmd>BufferLineGoToBuffer 6<cr>')
nmap('<space>7', '<Cmd>BufferLineGoToBuffer 7<cr>')
nmap('<space>8', '<Cmd>BufferLineGoToBuffer 8<cr>')
nmap('<space>9', '<Cmd>BufferLineGoToBuffer 9<cr>')
