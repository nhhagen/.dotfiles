zmodload zsh/zprof

eval "$(/opt/homebrew/bin/brew shellenv)"

export LANGUAGE=C
export LC_ALL=en_US.UTF-8

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

GPG_TTY=$(tty)
export GPG_TTY

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# export TERM=xterm-256color-italic

# export JAVA_HOME=$(/usr/libexec/java_home)
# export PATH=$JAVA_HOME/bin:/usr/local/bin:$PATH
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

if [ -d `brew --prefix` ]; then
    export PATH="`brew --prefix`/sbin:$PATH"
fi

if [ -d `brew --prefix`/share/zsh-completions ]; then
    fpath=(`brew --prefix`/share/zsh-completions $fpath)
fi


if [ -f `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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

if [ -f `brew --prefix fzf` ]; then
    source `brew --prefix fzf`/shell/completion.zsh
    source `brew --prefix fzf`/shell/key-bindings.zsh
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

export ACKRC=".ackrc"
export EDITOR=nvim

# Tell ls to be colourful
export CLICOLOR=1

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

export EVENT_NOKQUEUE=1

export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


export CLOUDSDK_PYTHON

if [ -f `pyenv prefix gcp-sdk`/bin/python ]; then
    export CLOUDSDK_PYTHON=`pyenv prefix gcp-sdk`/bin/python
fi

source $HOME/.alias

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

export PATH=~/bin:~/.scripts:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/niels.hagen/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Node version manager
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
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Google Cloud SDK
export GCLOUD_SDK_DIR="/Users/niels.hagen/.google-cloud-sdk"
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$GCLOUD_SDK_DIR/path.zsh.inc" ]; then source "$GCLOUD_SDK_DIR/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$GCLOUD_SDK_DIR/completion.zsh.inc" ]; then source "$GCLOUD_SDK_DIR/completion.zsh.inc"; fi
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# command -v flux >/dev/null && . <(flux completion zsh) && compdef _flux flux
# command -v pip >/dev/null && eval $(pip completion --zsh)
export PATH="/usr/local/opt/ruby/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"

# export GOPATH="$HOME/.go"

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"

eval "$(goenv init -)"

export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

export PATH="$HOME/.tfenv/bin:$PATH"

if [ -d `brew --prefix libpq`/bin ]; then
    export PATH="$(brew --prefix libpq)/bin:$PATH"
fi

eval "$(direnv hook zsh)"

eval "$(starship init zsh)"

if [ -d `brew --prefix openjdk`/bin ]; then
    export PATH="$(brew --prefix openjdk)/bin:$PATH"
fi

