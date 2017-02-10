highlight javaScriptClass ctermfg=222 guifg=#f0c674
syntax match javaScriptClass "\v<[A-Z]+[A-Za-z0-9]+>"
syntax match javaScriptClass "\v<[A-Z]+[A-Za-z0-9]+[A-Z]+[A-Za-z0-9]+>"
highlight javascriptClassName ctermfg=222 guifg=#f0c674

syntax match Constant "\v<[A-Z]+[A-Z0-9]+>"
syntax match Constant "\v<[A-Z]+[A-Z0-9]+_+[A-Z0-9]+>"

" syntax region  javascriptTemplateSubstitution  contained matchgroup=javascriptTemplateSB start=/\${/ end=/}/ contains=@javascriptExpression
syntax region javascriptTemplateSubstitution  contained matchgroup=javascriptTemplateSB start=/\${/ end=/}/ contains=javascriptTemplateSBlock,javascriptTemplateSString
syntax region  javascriptTemplateSBlock        contained start=/{/ end=/}/ contains=javascriptTemplateSBlock,javascriptTemplateSString transparent
syntax region  javascriptTemplateSString       contained start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/ extend contains=javascriptTemplateSStringRB transparent
syntax match   javascriptTemplateSStringRB     /}/ contained
syntax region  javascriptString                start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/ nextgroup=@javascriptComments skipwhite skipempty
syntax region  javascriptTemplate              start=/`/  skip=/\\\\\|\\`\|\n/  end=/`\|$/ contains=javascriptTemplateSubstitution nextgroup=@javascriptComments,@javascriptSymbols skipwhite skipempty
hi link  javascriptTemplate String
"hi link javascriptTemplateSubstitution Identifier
highlight javascriptTemplateSubstitution ctermfg=222 guifg=#f0c674

"highlight Label ctermfg=222 guifg=#f0c674
