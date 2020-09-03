CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .git .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all:

list:
	@echo "List of dotfiles:"
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy:
	@echo "Deploying dotfiles and directories:"
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

update:
	git pull origin master

