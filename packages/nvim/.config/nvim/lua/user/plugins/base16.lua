return {
  "RRethy/nvim-base16",
  config = function()
    local base16theme = os.getenv("BASE16_THEME")

    if base16theme then
      require("base16-colorscheme").setup(
        base16theme,
        {
          telescope = false,
          indentblankline = true,
          notify = true,
          ts_rainbow = true,
          cmp = true,
          illuminate = true,
          dapui = true,
        }
      )
      -- require('base16-colorscheme').with_config({
      --   telescope = true,
      --   indentblankline = true,
      --   notify = true,
      --   ts_rainbow = true,
      --   cmp = true,
      --   illuminate = true,
      --   dapui = true,
      -- })
      -- require("base16-colorscheme").setup()
      -- vim.cmd("colorscheme base16-" .. base16theme)
    end


    -- vim.cmd([[
    --  if exists("$BASE16_THEME") && (!exists("g:colors_name") || g:colors_name != "base16-$BASE16_THEME")
    --    let base16colorspace=256
    --    colorscheme base16-$BASE16_THEME
    --  endif
    -- ]])
  end,
}
