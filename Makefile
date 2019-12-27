.PHONY: install brew brew-tap brew-install dotfiles xcode hello brew-update

DOTFILES_DIR := $(PWD)
DOTFILES := $(shell ls | grep -v -E ".*\.sh$$|\..*$$|Makefile$$|LICENSE$$|.*\.md$$|LM-Tomorrow-Night$$|Meslo-Font$$|Smyck-Color-Scheme$$|powerline-fontpatcher$$")
PREDEF_DOTFILES := $(addprefix $(HOME)/.,$(DOTFILES))

BREW := /usr/local/bin/brew
BREW_PACKAGES := ack\
	battery\
	docker-machine\
	docker\
	git-flow-avh\
	git-standup\
	git\
	gnupg\
	make\
	pyenv-virtualenv\
	pyenv\
	reattach-to-user-namespace\
	spark\
	the_silver_searcher\
	tig\
	tmux\
	tree\
	vim\
	wget\
	zsh-completions\
	zsh-syntax-highlighting \
	zsh

GEMS := tmuxinator

install: $(BREW_PACKAGES) $(GEMS) $(PREDEF_DOTFILES) xcode scripts bin bash_profile google-cloud-sdk

brew: |$(BREW) xcode
$(BREW):
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew-update: brew
	$(BREW) update

brew-tap: brew
	$(BREW) tap Goles/battery

brew-install: $(BREW_PACKAGES)
$(BREW_PACKAGES): brew-update brew-tap Makefile
	$(BREW) list $@ &>/dev/null || $(BREW) install $@

gem-install: $(GEMS)
$(GEMS): $(BREW_PACKAGES) Makefile
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
$(HOME)/.bash_profile: $(DOTFILES)
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
