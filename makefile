dotfiles=${HOME}/dotFiles
brewfile=$(dotfiles)/homebrew/Brewfile

.PHONY: brew-update brew-install git-update sym-refresh

update: brew-update git-update sym-refresh

brew-update:
	@echo "Updating Brewfile with all current Homebrew packages..."
	@brew bundle dump --file=$(brewfile) --force

brew-install:
	@echo "Installing Homebrew packages in Brewfile..."
	@brew bundle --file=$(brewfile)

git-update:
	@echo "Updating dotFiles github repository..."
	@-(git add . && git commit -m "update dotfiles from make" && git push) &> /dev/null

sym-refresh:
	@echo "Refreshing all symlinks..."
	@sh $(dotfiles)/symLinks.bash &> /dev/null

