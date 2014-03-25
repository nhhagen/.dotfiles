"Take care of indents for Java.
setlocal autoindent
setlocal si
setlocal tabstop=4
setlocal shiftwidth=4
setlocal foldmethod=syntax
""Java anonymous classes. Sometimes, you have to use them.
setlocal cinoptions+=j1

let java_comment_strings=1
let java_highlight_java_lang_ids=1

let java_mark_braces_in_parens_as_errors=1
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_java_lang_ids=1
"let java_highlight_functions="style"
let java_minlines = 150

let g:EclimCompletionMethod = 'omnifunc'
