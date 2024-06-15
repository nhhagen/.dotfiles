vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move between buffers
vim.keymap.set("", "<C-h>", ":bp<CR>", { desc = "Buffer: Previous", silent = true })
vim.keymap.set("", "<C-l>", ":bn<CR>", { desc = "Buffer: Next", silent = true })

-- Allow gf to open non-existent files
vim.keymap.set("", "gf", ":edit <cfile><CR>", { desc = "Create file from reference", silent = true })

-- Reselect visual selection after indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent: Move left", silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Indent: Move right", silent = true })
