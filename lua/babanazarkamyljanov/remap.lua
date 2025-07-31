vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "<leader>y", '"+y') -- Visual: yank selected text
vim.keymap.set("n", "<leader>y", '"+y') -- Normal: yank selected text
vim.keymap.set("v", "<leader>p", '"+p') -- Visual: paste selected text
vim.keymap.set("n", "<leader>p", '"+p') -- Normal: paste selected text

