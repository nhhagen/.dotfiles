# -*- mode: zsh -*-
# vi: set ft=sh :

alias ccat='pygmentize -g'

# List the largest files/directory in directory
alias ducks='du -a * | sort -rn | head'
alias top-commands="history | awk '{a[\$2]++ } END{for(i in a){print a[i] \" \" i}}'|sort -rn |head -n 20"

# Git
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gd='git diff'
alias glg='git lg'
alias glga='git lga'
alias gp='git push'
alias gpf='git push -f'
alias gpr='git pull --rebase'
alias grd='git rebase develop'
alias gs='git status'

# Git flow
alias gffs='git flow feature start'
alias gfff='git flow feature finish --keepremote'
alias gfrs='git flow release start'
alias gfrf='git flow release finish --keepremote'

# Vagrant
alias vu='Vagrant up'
alias vh='Vagrant halt'
alias vhf='vagrant halt -f'
alias vssh='vagrant ssh'

# Tmuxinator
alias mux='tmuxinator'

# The silver searcher
alias ag='ag --path-to-agignore ~/.agignore'

#pip

alias pip-update-all='pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'

#tig
alias tig='tig --show-signature'
