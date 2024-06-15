require("lualine").setup({
  options = {
    theme = "base16",
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = ""},
  },
  sections = {
    lualine_b = {"branch", "diff", "diagnostics"},
    lualine_c = {{"filename", symbols = {modified = "●"}, path = 1}, "nvim_treesitter#statusline"},
  },
})
