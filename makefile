dotfiles=${HOME}/dotFiles

.PHONY: git-update sym-update

update: git-update sym-update

git-update:
	@echo "Updating dotFiles github repository..."
	@-(git add . && git commit -m "update dotfiles from make" && git push) > /dev/null 2>&1

sym-update:
	@echo "Updating all symlinks..."
	@sh $(dotfiles)/symlinks.sh &> /dev/null

