LUA ?= lua
LUAC ?= luac
LUACHECK ?= luacheck
PYTHON ?= python3
SHELLCHECK ?= .venv/bin/shellcheck
BASHATE ?= .venv/bin/bashate

LUA_FILES := zul-reset-calculator.lua tests.lua
SHELL_FILES := install.sh

.PHONY: venv syntax lint shell-lint test diff-check

venv:
	$(PYTHON) -m venv .venv
	.venv/bin/python -m pip install bashate shellcheck-py

syntax:
	$(LUAC) -p $(LUA_FILES)

lint:
	$(LUACHECK) $(LUA_FILES)

shell-lint:
	$(SHELLCHECK) $(SHELL_FILES)
	$(BASHATE) $(SHELL_FILES)

test: syntax
	$(LUA) tests.lua

diff-check:
	git diff --check
