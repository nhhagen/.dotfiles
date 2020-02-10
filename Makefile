.PHONY: install brew brew-tap brew-install dotfiles xcode hello brew-update terraform

DOTFILES_DIR := $(PWD)
DOTFILES := $(shell ls | grep -v -E ".*\.sh$$|\..*$$|Makefile$$|LICENSE$$|.*\.md$$|LM-Tomorrow-Night$$|Meslo-Font$$|Smyck-Color-Scheme$$|powerline-fontpatcher$$")
PREDEF_DOTFILES := $(addprefix $(HOME)/.,$(DOTFILES))

BREW := /usr/local/bin/brew
BREW_PACKAGES := ack\
	battery\
	cookiecutter \
	docker-machine\
	docker\
	git-flow-avh\
	git-standup\
	git\
	gnupg\
	make\
	neovim \
	pyenv-virtualenv\
	pyenv\
	reattach-to-user-namespace\
	spark\
	the_silver_searcher\
	tig\
	tmux\
	tmuxinator \
	tree\
	vim\
	wget\
	zsh-completions\
	zsh-syntax-highlighting \
	zsh

BREW_PACKAGES_PATHS := $(addprefix /usr/local/Cellar/,$(BREW_PACKAGES))

GEMS :=

install: $(BREW_PACKAGES_PATHS) $(GEMS) $(PREDEF_DOTFILES) xcode scripts bin bash_profile google-cloud-sdk sdkman terraform

brew: |$(BREW) xcode
$(BREW):
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew-update: brew
	$(BREW) update

brew-tap: brew
	$(BREW) tap Goles/battery

brew-install: |$(BREW_PACKAGES_PATHS)
$(BREW_PACKAGES_PATHS): |$(BREW)
	$(BREW) install $(patsubst .%,%,$(notdir $@))

gem-install: $(GEMS)
$(GEMS): |$(BREW_PACKAGES_PATHS)
	sudo gem install $@

dotfiles: |$(PREDEF_DOTFILES)
$(PREDEF_DOTFILES):
	ln -Fsv $(PWD)/$(patsubst .%,%,$(notdir $@)) $@

scripts: $(HOME)/scripts
$(HOME)/scripts:
	ln -Fsv $(PWD)/$(patsubst .%,%,$(notdir $@)) $@

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

terraform: $(HOME)/bin/terraform
$(HOME)/bin/terraform: |$(HOME)/bin
	curl "https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_darwin_amd64.zip" > terraform.zip
	unzip terraform.zip -d $(HOME)/bin/
	rm terraform.zip

