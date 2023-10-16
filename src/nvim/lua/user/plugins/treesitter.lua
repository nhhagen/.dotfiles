require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = {
    enable = true,
    disable = { "NvimTree", "yaml", "gitcommit", "ini" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
      },
    },
  },
  context_commentstring = {
    enable = true,
  },
})
