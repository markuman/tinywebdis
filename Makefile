LUAROCKS= luarocks-5.1

arch: ## Install system dependencies on arch linux
	@echo "Installing system requirements using pacman"
	@sudo pacman -Sy redis luajit luarocks5.1 base-devel
	@make install
	
ubuntu: ## Install system dependencies on ubuntu
	@echo "Installing system requirements using apt-get"
	@sudo apt-get install redis-server redis-tools luajit luarocks gcc libssl-dev
	@make install LUAROCKS=luarocks

install: ## Install turbowebdis dependencies locally
	@echo "Installing lsocket"
	@$(LUAROCKS) install lsocket --local
	@echo "Installing turbo"
	@PREFIX=$$HOME/.luarocks/ $(LUAROCKS) install turbo --local
	@echo "setup environment path"
	@$(LUAROCKS) path >> $$HOME/.bashrc
	@echo "copy resp"
	@cp resp/resp.lua ./

start: ## Start turbowebdis
	@echo "Starting turbowebdis"
	@source $$HOME/.bashrc
	@./turbowebdis.lua & echo "$$!" > turbo.pid
	
stop: turbo.pid ## Stop turbowebdis
	@echo "Stopping turbowebdis"
	@kill `cat $<` && rm $<
	
uninstall: ## Uninstall turbo dependencies
	@echo "removing lsocket"
	@$(LUAROCKS) remove lsocket --local
	@echo "removing turbo"
	@$(LUAROCKS) remove turbo --local

tabularasa: ## Tabula rasa
	@echo "reset git repository"
	@git reset --hard
	@echo "remove local luarocks path"
	@rm -rf $$HOME/.luarocks/
	@echo "flush redis db"
	@echo "flushdb"| redis-cli
	
	
.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

