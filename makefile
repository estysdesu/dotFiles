DOTFILES=${HOME}/dotFiles

.PHONY: update

update:
	brew bundle dump --file=$(DOTFILES)/.brewfile --force
	git add . && git commit -m "update dotfiles from make" && git push
	sh $(DOTFILES)/symLinks

