local vs_colors = require("vscode.colors")

 require("vscode").setup({
        group_overrides = {
                TSKeyword = {fg = vs_colors.vscBlue},
        },
        -- italic_comments = true,
        --disable_nvimtree_bg = true,

})

require("vscode").load()


