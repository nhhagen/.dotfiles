.PHONY: install brew brew-update brew-tap brew-install dotfiles xcode brew-update base16-shell input-font nvim-config nvm node neovim script-config

ROOT_DIR := $(PWD)

SCRIPTS := $(ROOT_DIR)/scripts
STAMPS := $(ROOT_DIR)/.stamps

DOT_CONFIG := $(HOME)/.config
BIN := $(HOME)/bin

DIRS := $(HOME)/code $(BIN) $(DOT_CONFIG) $(STAMPS) $(STAMPS)/scripts

DOTFILES := $(shell ls src)
PREDEF_DOTFILES := $(addprefix $(HOME)/.,$(DOTFILES))

BREW := /usr/local/bin/brew

BREW_TAPS := \
	github/homebrew-gh \
	goles/homebrew-battery \
	teamookla/homebrew-speedtest

BREW_TAPS_PATH := /usr/local/Homebrew/Library/Taps
PREDEF_BREW_TAPS := $(addprefix $(BREW_TAPS_PATH)/,$(BREW_TAPS))

BREW_FORMULAS := \
	ack \
	bat \
	battery \
	cookiecutter \
	docker \
	docker-machine \
	fd \
	fzf \
	gh \
	git \
	git-flow-avh \
	git-standup \
	gnupg \
	gource \
	httpie \
	jq \
	make \
	node \
	pyenv \
	pyenv-virtualenv \
	reattach-to-user-namespace \
	ripgrep \
	spark \
	speedtest \
	terraform \
	the_silver_searcher \
	tig \
	tmux \
	tmuxinator \
	tree \
	vaulted \
	vim \
	wget \
	zsh \
	zsh-completions \
	zsh-syntax-highlighting

BREW_FORMULAS_PATHS := $(addprefix /usr/local/Cellar/,$(BREW_FORMULAS))
UNIVERSAL_CTAGS := /usr/local/Homebrew/Library/Taps/universal-ctags/homebrew-universal-ctags
BREW_CASKS := \
	1password \
	fanny \
	google-backup-and-sync \
	google-chrome \
	iterm2 \
	keybase \
	slack \
	spotify \
	virtualbox

BREW_CASKS_PATHS := $(addprefix /usr/local/Caskroom/,$(BREW_CASKS))

SCRIPT_CONFIGS_STAMPS := $(patsubst %.sh,$(STAMPS)/%.stamp,$(wildcard scripts/*.sh))

GEMS :=

PYENV_BIN := /usr/local/bin/pyenv
PYENV_VIRTUALENV_BIN := /usr/local/bin/pyenv-virtualenv
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

install: $(HOME)/code $(PREDEF_BREW_TAPS) $(BREW_FORMULAS_PATHS) $(UNIVERSAL_CTAGS) $(BREW_CASKS_PATHS) $(GEMS) base16-shell /usr/local/Cellar/neovim $(PREDEF_DOTFILES) $(DOT_CONFIG)/nvim nvm xcode scripts $(HOME)/bin bash_profile google-cloud-sdk sdkman input-font node script-config /Applications/Camera\ Settings.app

script-config: $(SCRIPT_CONFIGS_STAMPS)
$(STAMPS)/scripts/%.stamp: $(SCRIPTS)/%.sh |$(STAMPS)/scripts
	$<
	touch $@

brew: $(BREW)
$(BREW): |/Library/Developer/CommandLineTools
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew-update: |$(BREW)
	$(BREW) update

$(PREDEF_BREW_TAPS): |$(BREW)
	$(BREW) tap $(shell echo $@ | sed -e "s|$(BREW_TAPS_PATH)/\(.*\)/homebrew-\(.*\)|\1/\2|")

brew-install: |$(BREW_FORMULAS_PATHS) $(UNIVERSAL_CTAGS) $(BREW_CASKS_PATHS)

$(BREW_FORMULAS_PATHS): |$(BREW) $(PREDEF_BREW_TAPS)
	$(BREW) install $(patsubst .%,%,$(notdir $@))

$(UNIVERSAL_CTAGS):
	$(BREW) install --HEAD universal-ctags/universal-ctags/universal-ctags

$(BREW_CASKS_PATHS): |$(BREW)
	$(BREW) cask install $(patsubst .%,%,$(notdir $@))

gem-install: $(GEMS)
$(GEMS): |$(BREW_FORMULAS_PATHS)
	sudo gem install $@

dotfiles: |$(PREDEF_DOTFILES)
$(PREDEF_DOTFILES):
	ln -Fsv $(PWD)/src/$(patsubst .%,%,$(notdir $@)) $@

scripts: $(HOME)/scripts
$(HOME)/scripts:
	ln -Fsv $(PWD)/src/$(patsubst .%,%,$(notdir $@)) $@

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

/usr/local/Cellar/neovim: $(PYTHON_2_NEOVIM_LIB) $(PYTHON_3_NEOVIM_LIB) $(HOME)/.vimrc_background | $(BREW)
	$(BREW) install neovim

$(PYENV_BIN): /usr/local/Cellar/pyenv
$(PYENV_VIRTUALENV_BIN): /usr/local/Cellar/pyenv-virtualenv

$(PYTHON_DIRS): |$(PYENV_BIN)
	$(PYENV_BIN) install $(notdir $@)

$(PYENV_VERSIONS)/neovim2: $(PYTHON_2_DIR) |$(PYENV_BIN) $(PYENV_VIRTUALENV_BIN)
	$(PYENV_BIN) virtualenv $(PYTHON_2) $(notdir $@)

$(PYENV_VERSIONS)/neovim3: $(PYTHON_3_DIR) |$(PYENV_BIN) $(PYENV_VIRTUALENV_BIN)
	$(PYENV_BIN) virtualenv $(PYTHON_3) $(notdir $@)

$(PYTHON_2_NEOVIM_LIB): $(PYENV_VERSIONS)/neovim2
	PATH="$(PYENV_VERSIONS)/neovim2/bin:$$PATH" pip install --upgrade pip
	PATH="$(PYENV_VERSIONS)/neovim2/bin:$$PATH" pip install neovim

$(PYTHON_3_NEOVIM_LIB): $(PYENV_VERSIONS)/neovim3
	PATH="$(PYENV_VERSIONS)/neovim3/bin:$$PATH" pip install --upgrade pip
	PATH="$(PYENV_VERSIONS)/neovim3/bin:$$PATH" pip install neovim

cammera-settings: /Applications/Camera\ Settings.app
/Applications/Camera\ Settings.app:
	curl https://download01.logi.com/web/ftp/pub/techsupport/cameras/Webcams/LogiCameraSettings_3.0.12.pkg -o LogiCameraSettings_3.0.12.pkg
	sudo installer -pkg LogiCameraSettings_3.0.12.pkg -target /
	rm LogiCameraSettings_3.0.12.pkg
	sudo chown ${USER}:staff "$@"
	chmod 755 "$@"

$(DIRS):
	mkdir -p $@
