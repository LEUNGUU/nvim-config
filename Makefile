SHELL = /bin/bash
nvim ?= nvim
nvim_version := '${shell $(nvim) --version}'
XDG_DATA_HOME ?= $(HOME)/.local/share
VIM_DATA_HOME = $(XDG_DATA_HOME)/nvim

default: install

install:
	$(nvim) --headless\
		-c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	@echo


uninstall:
	rm -rf "$(VIM_DATA_HOME)"

test:
	$(info Testing NVIM 0.9.0+...)
	$(if $(shell echo "$(nvim_version)" | egrep "NVIM v0\.[9]"),\
		$(info OK),\
		$(error   .. You need Neovim 0.9.0 or newer))
	@echo All tests passed, hooray!

.PHONY: install uninstall test
