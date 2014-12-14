syntax match JavaLangClass "\<[A-Z]\+[a-zA-z0-9]\+[a-z0-9]\+\>"
" Include annotations inside folds
syn region javaFuncDef start="^\z(\s*\)\%(\%(public\|protected\|private\|static\|abstract\|final\|native\|synchronized\)[ \n]\+\)*\%(void\|boolean\|char\|byte\|short\|int\|long\|float\|double\|\%([A-Z][$A-Za-z0-9_]*\%(\_s*<\_s*[$A-Za-z0-9,_ <]\+\_s*>\%(\_s*>\)*\_s*\)\?\)\)\_s\+\%([a-zA-Z$0-9_][$A-Za-z0-9_]*\)\_s*(\_[^)]*)\_s*\%(throws\_s\+[A-Z]\k\+\%(\_s*,\_s*[A-Z]\k\+\)*\_s\{-}\)\?\_s*{" end="^\z1}\s*$" keepend transparent fold

" Prevent one line functions from messing up the folds
" This must appear after javaFuncDef due to vim's syntax rule priorities
syn region javaFuncDef start="^\z(\s*\)\%(@[A-Z]\k*\%((\_.\{-})\)\?\_s*\)*\%(\%(public\|protected\|private\|static\|abstract\|final\|native\|synchronized\)[ \n]\+\)*\%(void\|boolean\|char\|byte\|short\|int\|long\|float\|double\|\%([A-Z][$A-Za-z0-9_]*\%(\_s*<\_s*[$A-Za-z0-9,_ <]\+\_s*>\%(\_s*>\)*\_s*\)\?\)\)\_s\+\%([a-z][$A-Za-z0-9_]*\)\_s*(\_[^)]*)\_s*\%(throws\_s\+[A-Z]\k\+\%(\_s*,\_s*[A-Z]\k\+\)*\_s\{-}\)\?\_s*{" end="}\s*$" oneline keepend transparent

syn region javaConstructorDef start="^\z(\s*\)\(public\|protected\|private\)\?[ \n]\+[A-Z][A-Za-z0-9_$]*[ \n]*(\_[^)]*)" end="^\z1}$" keepend transparent fold

syn region java5EnumDef start="^\z(\s*\)\%(@[A-Z]\k*\%((\_.\{-})\)\?\_s*\)*\%(\%(public\|protected\|private\|static\|final\)\_s\+\)*enum\_s\+\%([$A-Za-z0-9_]*\)\_s*{" end="^\z1}\s*$" keepend transparent fold

" Fold one line comments if there are multiple
"syn region javaMultipleOneLineCommentFold start="^\z(\s*\(//\)\)" skip="^\z1" end="^\z1\@!" transparent fold
syn region javaMultiLineComment start="/[*]\{1,}" end="[*]/" keepend transparent fold

syn keyword javaExternal native package
syn region foldImports start=/\(^\s*\n^import\)\@<= .\+;/ end=+^\s*$+ transparent fold keepend
