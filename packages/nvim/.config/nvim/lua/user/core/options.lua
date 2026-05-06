-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.g.python_host_prog = "$HOME/.pyenv/versions/neovim2/bin/python"
vim.g.python2_host_prog = "$HOME/.pyenv/versions/neovim2/bin/python"
vim.g.python3_host_prog = "$HOME/.pyenv/versions/neovim3/bin/python"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.hidden = true
vim.opt.signcolumn = "yes:2"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.ruler = true
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.spell = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmode = "longest:full,full"
vim.wo.wrap = false
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·" }
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- vim.opt.nojoinspaces = true
vim.opt.joinspaces = false
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
vim.opt.confirm = true
vim.opt.exrc = true
vim.opt.backspace = "indent,eol,start"

-- type plugin indent on
-- vim.opt.noswapfile = true
vim.opt.swapfile = false
-- vim.opt.nobackup = true
vim.opt.backup = false
-- vim.opt.nowritebackup = true
vim.opt.writebackup = false
-- syntax enable
vim.opt.encoding = "utf-8"
vim.opt.showcmd = true
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.wildmenu = true
-- vim.opt.noshowmode = true
vim.opt.showmode = false
vim.opt.laststatus = 2
