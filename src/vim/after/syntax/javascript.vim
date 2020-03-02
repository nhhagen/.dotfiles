syntax match javaScriptClass "\v<[A-Z]+[A-Za-z0-9]+>"
syntax match javaScriptClass "\v<[A-Z]+[A-Za-z0-9]+[A-Z]+[A-Za-z0-9]+>"
" highlight javaScriptClass ctermfg=03 guifg=#f0c674
" highlight javascriptClassName ctermfg=03 guifg=#f0c674

highlight javaScriptClass ctermfg=14 guifg=#f0c674
highlight javascriptClassName ctermfg=14 guifg=#f0c674

syntax match Constant "\v<[A-Z]+[A-Z0-9]+>"
syntax match Constant "\v<[A-Z]+[A-Z0-9]+_+[A-Z0-9]+>"

" Highlight ES6 template strings
hi javaScriptTemplateDelim ctermfg=16
hi javaScriptTemplateVar ctermfg=03
