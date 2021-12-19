function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
	map('n', shortcut, command)
end

function imap(shortcut, command)
	map('i', shortcut, command)
end

function vmap(shortcut, command)
	map('v', shortcut, command)
end

function cmap(shortcut, command)
	map('c', shortcut, command)
end

-- don't jump when using *
nmap('*', '*<c-o>')

-- better window navigation
nmap('<c-h>', '<c-w>h')
nmap('<c-j>', '<c-w>j')
nmap('<c-k>', '<c-w>k')
nmap('<c-l>', '<c-w>l')

-- resize with arrows
nmap('<c-Up>', ':resize -2<cr>')
nmap('<c-Down>', ':resize +2<cr>')
nmap('<c-Left>', ':vertical resize -2<cr>')
nmap('<c-Right>', ':vertical resize +2<cr>')

-- buffer navigation
nmap('<space>-', ':bprevious!<cr>')
nmap('<space>+', ':bnext!<cr>')
nmap('<space>=', ':bnext!<cr>')

-- Clear highlights
nmap('<c-L>', '<cmd>noh<cr>') 


-- Useful keymaps
-- <c-w>v -- Split window vertically
-- <c-w>s -- Split window horizontally
-- nzzzv -- Keep search matches in the middle of the window
