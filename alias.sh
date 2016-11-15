# -*- mode: zsh -*-
# vi: set ft=sh :

# List the largest files/directory in directory
alias ducks='du -a * | sort -rn | head'
alias top-commands="history | awk '{a[\$2]++ } END{for(i in a){print a[i] \" \" i}}'|sort -rn |head -n 20"

# Git
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v --amend'
alias glg='git lg'
alias gp='git push'
alias gpf='git push -f'
alias gpr='git pull --rebase'
alias grd='git rebase develop'

# Git flow
alias gffs='git flow feature start'
alias gfff='git flow feature finish'
alias gfrs='git flow release start'
alias gfrf='git flow release finish'

# Vagrant
alias vu='Vagrant up'
alias vh='Vagrant halt'
alias vhf='vagrant halt -f'
alias vssh='vagrant ssh'

# Tmuxinator
alias mux='tmuxinator'
