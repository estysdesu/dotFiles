.PHONY: git-update sym-refresh

update: git-update sym-refresh

git-update:
	@echo 'Updating dotFiles github repository...'
	@-(git add . && git commit -m "update dotfiles from make" && git push) > /dev/null 2>&1

sym-refresh:
	@echo 'Refreshing all symlinks...'
	@sh ./symLinks.sh > /dev/null 2>&1

