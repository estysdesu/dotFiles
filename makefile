# WiP
DOTFILES=$${HOME}/dotFiles

.PHONY: update

update:
	brew bundle dump --file=$(DOTFILES)/.brewfile --force
	sh $(DOTFILES)/symLinks

