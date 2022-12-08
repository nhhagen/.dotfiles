vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move between buffers
vim.keymap.set("", "<C-h>", ":bp<CR>")
vim.keymap.set("", "<C-l>", ":bn<CR>")

-- Allow gf to open non-existent files
vim.keymap.set("", "gf", ":edit <cfile><CR>")

-- Reselect visual selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
