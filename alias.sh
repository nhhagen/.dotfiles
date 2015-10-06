# -*- mode: zsh -*-
# vi: set ft=sh :

# List the largest files/directory in directory
alias ducks='du -a * | sort -rn | head'
alias top-commands="history | awk '{a[\$2]++ } END{for(i in a){print a[i] \" \" i}}'|sort -rn |head -n 20"
