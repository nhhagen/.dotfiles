return {
  "nathanaelkane/vim-indent-guides",
  config = function()
    vim.g.indent_guides_auto_colors = 0
    vim.g.indent_guides_guide_size = 1
    vim.g.indent_guides_start_level = 2
    -- vim.cmd([[highlight IndentGuidesOdd  ctermbg=19 guibg=#2e3c43]])
    -- vim.cmd([[highlight IndentGuidesEven ctermbg=19 guibg=#2e3c43]])
    -- vim.cmd([[au VimEnter * :IndentGuidesEnable]])
  end,
}
