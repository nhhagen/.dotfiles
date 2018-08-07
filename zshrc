unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

export LANGUAGE=C

GPG_TTY=$(tty)
export GPG_TTY

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# export TERM=xterm-256color-italic

# export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.npm-packages/bin:/usr/local/share/npm/bin:$PATH

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTIGNOR='top-commands'
# setopt appendhistory extendedglob nomatch
# setopt hist_expire_dups_first
# setopt hist_find_no_dups
# setopt hist_ignore_all_dups
# setopt hist_ignore_dups
# setopt hist_ignore_space
# setopt hist_no_store
# setopt hist_reduce_blanks
# setopt hist_save_no_dups
# setopt hist_verify
# setopt no_hist_allow_clobber
# setopt no_hist_beep
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history
unsetopt beep
bindkey -v
bindkey '^R' history-incremental-search-backward
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

if [ -d `brew --prefix`/share/zsh-completions ]; then
    fpath=(`brew --prefix`/share/zsh-completions $fpath)
fi

if [ -f `brew --prefix`/share/zsh/site-functions/git-flow-completion.zsh ]; then
    source `brew --prefix`/share/zsh/site-functions/git-flow-completion.zsh
fi

if [ -f `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f ~/.zsh/git-flow-completion.zsh ]; then
    source ~/.zsh/git-flow-completion.zsh
fi

if [ -f `brew --prefix`/opt/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source `brew --prefix`/opt/zsh-history-substring-search/zsh-history-substring-search.zsh
    # bind k and j for VI mode
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
fi

if [ -f `brew --prefix ruby`/bin ]; then
    export PATH=$(brew --prefix ruby)/bin:$PATH
fi

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt shwordsplit
setopt PROMPT_SUBST
autoload -U promptinit && promptinit
autoload -U colors && colors

if [ -f `brew --prefix`/etc/profile.d/colorsvn-env.sh ]; then
    source `brew --prefix`/etc/profile.d/colorsvn-env.sh
fi

export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="verbose"
export GIT_PS1_SHOWCOLORHINTS=true

export ACKRC=".ackrc"
export EDITOR=vim

# Tell ls to be colourful
export CLICOLOR=1

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

export EVENT_NOKQUEUE=1

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

if which goenv > /dev/null; then eval "$(goenv init -)"; fi

source $HOME/.zsh_prompt
source $HOME/.alias

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

function newproject() { curl https://raw.github.com/nhhagen/vagrant-dev-box/master/setup.sh | bash -s $@ ; }

export CLOUDSDK_PYTHON=python

# The next line updates PATH for the Google Cloud SDK.
source $HOME/google-cloud-sdk/path.zsh.inc

# The next line enables shell command completion for gcloud.
source $HOME/google-cloud-sdk/completion.zsh.inc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use >/dev/null 2>&1
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    # echo "Reverting to nvm default version"
    nvm use default >/dev/null 2>&1
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
export PATH=~/bin:~/scripts:$PATH
