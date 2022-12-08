local base16theme = os.getenv("BASE16_THEME")

if base16theme then
  require("base16-colorscheme").setup(
    base16theme,
    {
      telescope = false,
    }
  )
end


-- vim.cmd([[
--  if exists("$BASE16_THEME") && (!exists("g:colors_name") || g:colors_name != "base16-$BASE16_THEME")
--    let base16colorspace=256
--    colorscheme base16-$BASE16_THEME
--  endif
-- ]])
