return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      -- auto_install = true,
      -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "python", "bash", "terraform" },
      -- highlight = {
      --   enable = true,
      --   disable = { "NvimTree", "yaml", "gitcommit", "ini" },
      --   additional_vim_regex_highlighting = true,
      -- },
      -- indent = {
      --   enable = true
      -- },
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true,
      --     keymaps = {
      --       ["if"] = "@function.inner",
      --       ["af"] = "@function.outer",
      --       ["ic"] = "@class.inner",
      --       ["ac"] = "@class.outer",
      --       ["ia"] = "@parameter.inner",
      --       ["aa"] = "@parameter.outer",
      --     },
      --   },
      -- },
    })

    local languages = {
      "bash",
      "c",
      "go",
      "hcl",
      "json",
      "json5",
      "lua",
      "markdown",
      "python",
      "query",
      "rego",
      "terraform",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    }
    -- Install parsers asynchronously
    require('nvim-treesitter').install(languages)
  end,
}
