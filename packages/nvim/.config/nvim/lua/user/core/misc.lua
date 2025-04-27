local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
  group = packer_user_config
})

local mkdir = vim.api.nvim_create_augroup("Mkdir", { clear = true })
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = "*",
  command = 'call mkdir(expand("<afile>:p:h"), "p")',
  group = mkdir
})