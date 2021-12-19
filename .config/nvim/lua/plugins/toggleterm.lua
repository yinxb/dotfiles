require("toggleterm").setup{
  open_mapping = [[<c-\>]],
  close_on_exit = true,
  direction = 'float',
  float_opts = {
    border = 'double',
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}
