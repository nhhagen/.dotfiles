require("lualine").setup({
  options = {
    theme = "base16",
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = ""},
  },
  sections = {
    lualine_c = {{'filename', path = 1}},
  },
})
