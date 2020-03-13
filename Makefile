.PHONY: install brew brew-update brew-tap brew-install dotfiles xcode brew-update base16-shell input-font nvim-config nvm node neovim script-config

ROOT_DIR := $(PWD)
SCRIPTS := $(ROOT_DIR)/scripts
STAMPS := $(ROOT_DIR)/.stamps

DIRS := $(HOME)/code $(DOT_CONFIG) $(STAMPS) $(STAMPS)/scripts

DOTFILES := $(shell ls src)
PREDEF_DOTFILES := $(addprefix $(HOME)/.,$(DOTFILES))

DOT_CONFIG := $(HOME)/.config

BREW := /usr/local/bin/brew
BREW_PACKAGES := \
	ack \
	battery\
	cookiecutter \
	docker-machine\
	docker\
	git-flow-avh\
	git-standup\
	git\
	gnupg\
	httpie \
	make\
	node \
	pyenv-virtualenv\
	pyenv\
	reattach-to-user-namespace\
	spark\
	the_silver_searcher\
	terraform \
	tig\
	tmux\
	tmuxinator \
	tree\
	vaulted \
	vim\
	wget\
	zsh-completions\
	zsh-syntax-highlighting \
	zsh

BREW_PACKAGES_PATHS := $(addprefix /usr/local/Cellar/,$(BREW_PACKAGES))

BREW_CASKS := \
	1password \
	google-backup-and-sync \
	google-chrome \
	iterm2 \
	keybase \
	slack \
	virtualbox

BREW_CASKS_PATHS := $(addprefix /usr/local/Caskroom/,$(BREW_CASKS))

SCRIPT_CONFIGS_STAMPS := $(patsubst %.sh,$(STAMPS)/%.stamp,$(wildcard scripts/*.sh))

GEMS :=

PYENV_DIR := $(HOME)/.pyenv
PYENV_VERSIONS := $(PYENV_DIR)/versions
PYTHON_2_MINOR := 2.7
PYTHON_3_MINOR := 3.8

PYTHON_2 := $(PYTHON_2_MINOR).17
PYTHON_3 := $(PYTHON_3_MINOR).1

PYTHON_2_DIR := $(PYENV_VERSIONS)/$(PYTHON_2)
PYTHON_3_DIR := $(PYENV_VERSIONS)/$(PYTHON_3)

PYTHON_DIRS := $(PYTHON_2_DIR) $(PYTHON_3_DIR)

PYTHON_2_NEOVIM_LIB := $(PYENV_VERSIONS)/neovim2/lib/python$(PYTHON_2_MINOR)/site-packages/neovim
PYTHON_3_NEOVIM_LIB := $(PYENV_VERSIONS)/neovim3/lib/python$(PYTHON_3_MINOR)/site-packages/neovim

tmp:
	echo $(PREDEF_SCRIPT_CONFIGS)

install: script-config $(HOME)/code /usr/local/Homebrew/Library/Taps/goles/homebrew-battery $(BREW_PACKAGES_PATHS) $(BREW_CASKS_PATHS) $(GEMS) base16-shell neovim $(PREDEF_DOTFILES) $(DOT_CONFIG)/nvim nvm xcode scripts bin bash_profile google-cloud-sdk sdkman input-font node

script-config: $(SCRIPT_CONFIGS_STAMPS)
$(STAMPS)/scripts/%.stamp: $(SCRIPTS)/%.sh |$(STAMPS)/scripts
	$<
	touch $@

brew: $(BREW)
$(BREW): |/Library/Developer/CommandLineTools
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew-update: |$(BREW)
	$(BREW) update

/usr/local/Homebrew/Library/Taps/goles/homebrew-battery: |$(BREW)
	$(BREW) tap Goles/battery

brew-install: |$(BREW_PACKAGES_PATHS) $(BREW_CASKS_PATHS)

$(BREW_PACKAGES_PATHS): |$(BREW)
	$(BREW) install $(patsubst .%,%,$(notdir $@))

$(BREW_CASKS_PATHS): |$(BREW)
	$(BREW) cask install -f $(patsubst .%,%,$(notdir $@))

gem-install: $(GEMS)
$(GEMS): |$(BREW_PACKAGES_PATHS)
	sudo gem install $@

dotfiles: |$(PREDEF_DOTFILES)
$(PREDEF_DOTFILES):
	ln -Fsv $(PWD)/src/$(patsubst .%,%,$(notdir $@)) $@

scripts: $(HOME)/scripts
$(HOME)/scripts:
	ln -Fsv $(PWD)/src/$(patsubst .%,%,$(notdir $@)) $@

bin: $(HOME)/bin
$(HOME)/bin:
	mkdir -p $@

bash_profile: $(HOME)/.bash_profile
$(HOME)/.bash_profile: |$(HOME)/.bash_profile_mac
	ln -Fsv $(HOME)/.bash_profile_mac $@

nvim-config: $(DOT_CONFIG)/nvim
$(DOT_CONFIG)/nvim: |$(DOT_CONFIG)
	ln -Fsv $(PWD)/src/$(patsubst .%,%,$(notdir $@)) $@

xcode: |/Library/Developer/CommandLineTools
/Library/Developer/CommandLineTools:
	xcode-select --install

google-cloud-sdk: |$(HOME)/.google-cloud-sdk
$(HOME)/.google-cloud-sdk:
	curl https://sdk.cloud.google.com > google-cloud-install.sh
	bash google-cloud-install.sh --disable-prompts
	mv $(HOME)/google-cloud-sdk $(HOME)/.google-cloud-sdk
	rm google-cloud-install.sh

sdkman: |$(HOME)/.sdkman
$(HOME)/.sdkman:
	curl -s "https://get.sdkman.io" | bash

base16-shell: |$(HOME)/.config/base16-shell
$(HOME)/.config/base16-shell: |$(DOT_CONFIG)
	mkdir -p $@
	(set -e; \
	cd $@; \
	git init; \
	git remote add origin https://github.com/chriskempson/base16-shell.git; \
	git fetch origin; \
	git checkout -b master --track origin/master; \
	git reset origin/master)

input-font: $(HOME)/Library/Fonts/Input_Fonts
$(HOME)/Library/Fonts/Input_Fonts:
	mkdir -p $(dir $@)
	mkdir -p tmp
	curl "https://input.fontbureau.com/build/?fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do&email=" > tmp/Input-Font.zip
	unzip tmp/Input-Font.zip -d tmp
	mv tmp/Input_Fonts $(dir $@)
	rm -rf tmp

nvm: |$(HOME)/.nvm
$(HOME)/.nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
	source $(HOME)/.nvm/nvm.sh && nvm alias default system

node: |$(HOME)/.nvm/alias/default
$(HOME)/.nvm/alias/default: |$(HOME)/.nvm
	source $(HOME)/.nvm/nvm.sh && nvm alias default system

neovim: /usr/local/Cellar/neovim
/usr/local/Cellar/neovim: $(PYTHON_2_NEOVIM_LIB) $(PYTHON_3_NEOVIM_LIB) $(HOME)/.vimrc_background | $(BREW)
	$(BREW) install neovim

$(HOME)/.vimrc_background: |$(HOME)/.config/base16-shell
	base16_material

$(PYTHON_DIRS):
	pyenv install $(notdir $@)

$(PYENV_VERSIONS)/neovim2: $(PYTHON_2_DIR)
	pyenv virtualenv $(PYTHON_2) $(notdir $@)

$(PYENV_VERSIONS)/neovim3: $(PYTHON_3_DIR)
	pyenv virtualenv $(PYTHON_3) $(notdir $@)

$(PYTHON_2_NEOVIM_LIB): $(PYENV_VERSIONS)/neovim2
	PATH="$(PYENV_VERSIONS)/neovim2/bin:$$PATH" pip install --upgrade pip
	PATH="$(PYENV_VERSIONS)/neovim2/bin:$$PATH" pip install neovim

$(PYTHON_3_NEOVIM_LIB): $(PYENV_VERSIONS)/neovim3
	PATH="$(PYENV_VERSIONS)/neovim3/bin:$$PATH" pip install --upgrade pip
	PATH="$(PYENV_VERSIONS)/neovim3/bin:$$PATH" pip install neovim

$(DIRS):
	mkdir -p $@
