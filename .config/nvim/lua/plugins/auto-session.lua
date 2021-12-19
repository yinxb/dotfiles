require("auto-session").setup{
  log_level = 'error',
  pre_save_cmds = {"tabdo NvimTreeClose", "tabdo SymbolsOutlineClose", "tabdo TroubleClose"}
}
