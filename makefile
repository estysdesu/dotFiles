DOTFILES=${HOME}/dotFiles

.PHONY: brew-update git-update sym-refresh update

brew-update:
	@echo "updating Brewfile"
	brew bundle dump --file=$(DOTFILES)/Brewfile --force

git-update:
	@echo "updating github repository"
	git add . && git commit -m "update dotfiles from make" && git push

sym-refresh:
	@echo "refreshing all symlinks"
	sh $(DOTFILES)/symLinks

update:
	brew-update
	git-update
	sym-refresh
