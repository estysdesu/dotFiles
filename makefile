.PHONY: brew-update brew-install git-update sym-refresh

update: brew-update git-update sym-refresh

brew-update:
	@echo "Updating Brewfile with all current Homebrew packages..."
	@brew bundle dump --force

brew-install:
	@echo "Installing Homebrew packages in Brewfile..."
	@brew bundle 

git-update:
	@echo "Updating dotFiles github repository..."
	@-(git add . && git commit -m "update dotfiles from make" && git push) > /dev/null 2>&1

sym-refresh:
	@echo "Refreshing all symlinks..."
	@sh ./symLinks > /dev/null 2>&1

