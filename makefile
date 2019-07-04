dotfiles=${HOME}/dotFiles
brewfile=$(dotfiles)/homebrew/Brewfile

.PHONY:
	brew-update
	brew-install
	git-update
	sym-refresh
	update

brew-update:
	@echo "updating Brewfile with all current Homebrew packages"
	@brew bundle dump --file=$(brewfile) --force

brew-install:
	@echo "installing Homebrew packages in Brewfile"
	@brew bundle --file=$(brewfile)

git-update:
	@echo "updating dotFiles github repository"
	@git add . && git commit -m "update dotfiles from make" && git push

sym-refresh:
	@echo "refreshing all symlinks"
	@sh $(dotfiles)/symLinks

update:
	brew-update
	git-update
	sym-refresh
