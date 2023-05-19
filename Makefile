ROOT_DIR := $(PWD)

OS := $(shell uname)
ARCH := $(shell uname -m)

SCRIPTS := $(ROOT_DIR)/scripts
STAMPS := $(ROOT_DIR)/.stamps

DOT_CONFIG := $(HOME)/.config
BIN := $(HOME)/bin

DIRS := $(HOME)/code $(HOME)/code/personal $(HOME)/code/work $(BIN) $(DOT_CONFIG) $(STAMPS) $(STAMPS)/scripts
DOTFILES := $(shell ls src)
PREDEF_DOTFILES := $(addprefix $(HOME)/.,$(DOTFILES))


ifeq ($(shell uname -p),arm)
BREW_PATH := /opt/homebrew
else
BREW_PATH := /usr/local/homebrew
endif

BREW := $(BREW_PATH)/bin/brew

BREW_CELLAR := $(BREW_PATH)/Cellar/
BREW_CASK_ROOM := $(BREW_PATH)/Caskroom/
BREW_TAPS_PATH := $(BREW_PATH)/Library/Taps

BREW_TAPS := \
	github/homebrew-gh \
	goles/homebrew-battery \
	homebrew/homebrew-cask-fonts \
	teamookla/homebrew-speedtest

PREDEF_BREW_TAPS := $(addprefix $(BREW_TAPS_PATH)/,$(BREW_TAPS))

BREW_FORMULAS := \
	ack \
	aspell \
	azure-cli \
	bat \
	battery \
	cmake \
	cookiecutter \
	coreutils \
	fd \
	fzf \
	gh \
	git \
	git-flow-avh \
	git-standup \
	gnupg \
	gource \
	httpie \
	icu4c \
	jq \
	libpq \
	make \
	minikube \
	mysql-client \
	node \
	openssl@1.1 \
	openssl@3 \
	pkg-config \
	readline \
	reattach-to-user-namespace \
	ripgrep \
	ruby \
	spark \
	speedtest \
	sqlite \
	starship \
	terraform \
	the_silver_searcher \
	tig \
	tmux \
	tmuxinator \
	tree \
	vaulted \
	vim \
	wget \
	write-good \
	xz \
	yamllint \
	yq \
	zlib \
	zsh \
	zsh-completions \
	zsh-syntax-highlighting

BREW_FORMULAS_PATHS := $(addprefix $(BREW_CELLAR),$(BREW_FORMULAS))
UNIVERSAL_CTAGS := $(BREW_TAPS_PATH)/universal-ctags/homebrew-universal-ctags
BREW_CASKS := \
	1password \
	avibrazil-rdm \
	docker \
	fanny \
	figma \
	firefox \
	font-input \
	font-inter \
	google-drive \
	google-chrome \
	iterm2 \
	slack \
	spotify

BREW_CASKS_PATHS := $(addprefix $(BREW_CASK_ROOM),$(BREW_CASKS))

SCRIPT_CONFIGS_STAMPS := $(patsubst %.sh,$(STAMPS)/%.stamp,$(wildcard scripts/*.sh))

GEMS := # \
	# github-linguist

PYENV_DIR := $(HOME)/.pyenv
PYENV := $(PYENV_DIR)/bin/pyenv
PYENV_VERSIONS := $(PYENV_DIR)/versions
PYTHON_2_MINOR := 2.7
PYTHON_3_MINOR := 3.9

PYTHON_2 := $(PYTHON_2_MINOR).18
PYTHON_3 := $(PYTHON_3_MINOR).13

PYTHON_2_DIR := $(PYENV_VERSIONS)/$(PYTHON_2)
PYTHON_3_DIR := $(PYENV_VERSIONS)/$(PYTHON_3)

PYTHON_DIRS := $(PYTHON_2_DIR) $(PYTHON_3_DIR)

PYTHON_2_NEOVIM_LIB := $(PYENV_VERSIONS)/neovim2/lib/python$(PYTHON_2_MINOR)/site-packages/neovim
PYTHON_3_NEOVIM_LIB := $(PYENV_VERSIONS)/neovim3/lib/python$(PYTHON_3_MINOR)/site-packages/neovim

POETRY_HOME := $(HOME)/.poetry

install: \
	$(HOME)/code \
	$(PREDEF_BREW_TAPS) \
	$(BREW_FORMULAS_PATHS) \
	$(UNIVERSAL_CTAGS) \
	$(BREW_CASKS_PATHS) \
	base16-shell \
	$(BREW_CELLAR)/neovim \
	$(PREDEF_DOTFILES) \
	$(DOT_CONFIG)/nvim \
	$(DOT_CONFIG)/starship.toml \
	nvm \
	xcode \
	scripts \
	$(HOME)/bin \
	bash_profile \
	google-cloud-sdk \
	sdkman \
	node \
	script-config \
	/Applications/Camera\ Settings.app \
	$(PYENV) \
	$(HOME)/.goenv \
	$(HOME)/.tfenv \
	$(POETRY_HOME) \
	$(HOME)/.docker/cli-plugins/docker-lock \
	$(GEMS)

script-config: $(SCRIPT_CONFIGS_STAMPS)
$(STAMPS)/scripts/%.stamp: $(SCRIPTS)/%.sh |$(STAMPS)/scripts
	$<
	touch $@

brew: $(BREW)
$(BREW): |/Library/Developer/CommandLineTools
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
	$(BREW) install --cask $(patsubst .%,%,$(notdir $@))

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

starship-config: $(DOT_CONFIG)/starship.toml
$(DOT_CONFIG)/starship.toml: |$(DOT_CONFIG)
	ln -Fsv $(PWD)/src/$(patsubst .%,%,$(notdir $@)) $@

xcode: |/Library/Developer/CommandLineTools
/Library/Developer/CommandLineTools:
	xcode-select --install

$(PYENV_VERSIONS)/gcp-sdk: $(PYTHON_3_DIR) |$(PYENV)
	$(PYENV) virtualenv -f $(PYTHON_3) $(notdir $@)

google-cloud-sdk: |$(HOME)/.google-cloud-sdk
$(HOME)/.google-cloud-sdk: $(PYENV_VERSIONS)/gcp-sdk
	curl https://sdk.cloud.google.com > google-cloud-install.sh
	CLOUDSDK_PYTHON=`$(PYENV) prefix gcp-sdk`/bin/python bash google-cloud-install.sh --disable-prompts
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

# input-font: $(HOME)/Library/Fonts/Input_Fonts
# $(HOME)/Library/Fonts/Input_Fonts:
# 	mkdir -p $(dir $@)
# 	mkdir -p tmp
# 	curl "https://input.fontbureau.com/build/?fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do&email=" > tmp/Input-Font.zip
# 	unzip tmp/Input-Font.zip -d tmp
# 	mv tmp/Input_Fonts $(dir $@)
# 	rm -rf tmp

nvm: |$(HOME)/.nvm
$(HOME)/.nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
	source $(HOME)/.nvm/nvm.sh && nvm alias default system

node: |$(HOME)/.nvm/alias/default
$(HOME)/.nvm/alias/default: |$(HOME)/.nvm
	source $(HOME)/.nvm/nvm.sh && nvm alias default system

/usr/local/Cellar/neovim: $(PYTHON_3_NEOVIM_LIB) | $(HOME)/.vimrc_background $(BREW)
	$(BREW) install neovim

pyenv: $(PYENV)
$(PYENV): |/usr/bin/curl
	curl https://pyenv.run | bash

$(PYTHON_DIRS): |$(PYENV)
	$(PYENV) install $(notdir $@)

# $(PYENV_VERSIONS)/neovim2: $(PYTHON_2_DIR) |$(PYENV)
# 	$(PYENV) virtualenv $(PYTHON_2) $(notdir $@)

$(PYENV_VERSIONS)/neovim3: $(PYTHON_3_DIR) |$(PYENV)
	$(PYENV) virtualenv $(PYTHON_3) $(notdir $@)

# $(PYTHON_2_NEOVIM_LIB): $(PYENV_VERSIONS)/neovim2
# 	PATH="$(PYENV_VERSIONS)/neovim2/bin:$$PATH" pip install --upgrade pip
# 	PATH="$(PYENV_VERSIONS)/neovim2/bin:$$PATH" pip install neovim

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

goenv: $(HOME)/.goenv
$(HOME)/.goenv: |$(BREW_CELLAR)git $(HOME)/.zshrc
	git clone https://github.com/syndbg/goenv.git $@

tfenv: $(HOME)/.tfenv
$(HOME)/.tfenv: |$(BREW_CELLAR)git $(HOME)/.zshrc
	git clone https://github.com/tfutils/tfenv.git $@

$(PYENV_VERSIONS)/poetry: $(PYTHON_3_DIR) |$(PYENV)
	$(PYENV) virtualenv $(PYTHON_3) $(notdir $@)

poetry: $(POETRY_HOME)
$(POETRY_HOME): $(PYENV_VERSIONS)/poetry
	PATH="$(PYENV_VERSIONS)/poetry/bin:$$PATH" curl -sSL https://install.python-poetry.org | POETRY_HOME=$(POETRY_HOME) python3 -

DOCKER_LOCK_VERSION := 0.8.10
docker-lock: $(HOME)/.docker/cli-plugins/docker-lock
$(HOME)/.docker/cli-plugins/docker-lock:
	mkdir -p "$(HOME)/.docker/cli-plugins"
	curl -fsSL "https://github.com/safe-waters/docker-lock/releases/download/v$(DOCKER_LOCK_VERSION)/docker-lock_$(DOCKER_LOCK_VERSION)_$(OS)_$(ARCH).tar.gz" | tar -xz -C "$(HOME)/.docker/cli-plugins" "docker-lock"
	chmod +x "$(HOME)/.docker/cli-plugins/docker-lock"

dirs: $(DIRS)
$(DIRS):
	mkdir -p $@

clean:
	$(foreach dotfile, $(PREDEF_DOTFILES), unlink $(dotfile) &&) true

.PHONY: \
	base16-shell \
	brew \
	brew-install \
	brew-tap \
	brew-update \
	brew-update \
	dirs \
	docker-lock \
	dotfiles \
	input-font \
	install \
	neovim \
	node \
	nvim-config \
	nvm \
	script-config \
	xcode
