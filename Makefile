.PHONY: install brew brew-update brew-tap brew-install dotfiles xcode brew-update base16-shell input-font

DOTFILES_DIR := $(PWD)
DOTFILES := $(shell ls src)
PREDEF_DOTFILES := $(addprefix $(HOME)/.,$(DOTFILES))

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
	neovim \
	node \
	nvm \
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

GEMS :=

install: brew-tap $(BREW_PACKAGES_PATHS) $(BREW_CASKS_PATHS) $(GEMS) base16-shell $(PREDEF_DOTFILES) xcode scripts bin bash_profile google-cloud-sdk sdkman input-font

brew: $(BREW)
$(BREW): |/Library/Developer/CommandLineTools
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew-update: |$(BREW)
	$(BREW) update

brew-tap: |$(BREW)
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
$(HOME)/.config/base16-shell:
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
	mkdir -p tmp
	curl "https://input.fontbureau.com/build/?fontSelection=whole&a=0&g=0&i=0&l=0&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do&email=" > tmp/Input-Font.zip
	unzip tmp/Input-Font.zip -d tmp
	mv tmp/Input_Fonts $(HOME)/Library/Fonts
	rm -rf tmp
