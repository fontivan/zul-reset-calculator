LUA ?= lua
LUAC ?= luac
LUACHECK ?= luacheck

LUA_FILES := zul-reset-calculator.lua tests.lua

.PHONY: syntax lint test diff-check

syntax:
	$(LUAC) -p $(LUA_FILES)

lint:
	$(LUACHECK) $(LUA_FILES)

test: syntax
	$(LUA) tests.lua

diff-check:
	git diff --check
