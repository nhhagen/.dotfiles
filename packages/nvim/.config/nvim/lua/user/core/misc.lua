-- local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", { clear = true })

-- vim.api.nvim_create_autocmd({"BufWritePost"}, {
--   pattern = "plugins.lua",
--   command = "source <afile> | PackerCompile",
--   group = packer_user_config
-- })

local mkdir = vim.api.nvim_create_augroup("Mkdir", { clear = true })
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = "*",
  command = 'call mkdir(expand("<afile>:p:h"), "p")',
  group = mkdir
})


vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype

    -- 1. Ignore "special" buffers (Telescope, Alpha, etc.)
    if vim.bo[bufnr].buftype ~= "" then
      return
    end

    -- 2. Check if a Tree-sitter parser actually exists for this filetype
    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then return end

    -- 3. Use pcall to catch any remaining edge-case errors silently
    pcall(vim.treesitter.start, bufnr, lang)
  end,
})
