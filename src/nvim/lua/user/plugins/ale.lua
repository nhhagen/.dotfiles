vim.g["airline#extensions#ale#enabled"] = 1
vim.g.ale_echo_msg_format = "[%severity%: %linter%: %code%] %s"
vim.g.ale_sign_error = "✘"
vim.g.ale_sign_warning = "⚠"

vim.cmd([[highlight ALEErrorSign ctermbg=18 ctermfg=1 guibg=#2e3c43 guifg=#f07178]])
vim.cmd([[highlight ALEWarningSign ctermbg=18 ctermfg=3 guibg=#2e3c43 guifg=#ffcb6b]])
