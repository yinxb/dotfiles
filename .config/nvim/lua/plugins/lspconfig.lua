require('keymaps')

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
	runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },
        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },	
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,	    
            highlight = "Comment",	    
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
	capabilities = capabilities,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)

lspconfig = require "lspconfig"
lspconfig.gopls.setup {
	cmd = {"gopls", "serve"},
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				},
			staticcheck = true,
			},
		},
}

function goimports(timeout_ms)
    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end

nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
nmap('gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
nmap('gr', '<cmd>lua vim.lsp.buf.references()<cr>')
nmap('K', '<cmd>lua vim.lsp.buf.hover()<cr>')
nmap('<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
nmap('<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>')
nmap('g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
nmap('g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')
nmap('ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')
nmap('<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
imap('<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
vmap('<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

vim.cmd('autocmd! BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)')

vim.cmd('autocmd! BufWritePre *.go lua goimports(1000)')
vim.cmd('autocmd! BufWritePre *.go lua vim.lsp.buf.format')
vim.cmd('autocmd! FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc')


