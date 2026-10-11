# zul-reset-calculator

An addon for World of Warcraft to calculate resets for 3-day reset raids like Zul'Gurub and Blackfathom Depths inside the game client.

## Installation

The addon is available on CurseForge and can be installed with one click.

## Manual Installation

Run `install.sh` with the path to an existing World of Warcraft `AddOns` directory:

```sh
./install.sh "$HOME/Games/World of Warcraft/_classic_/Interface/AddOns"
```

Use `./install.sh --help` to display usage. The script replaces the existing
`zul-reset-calculator` addon folder in the destination.

If you prefer to install manually instead, create `zul-reset-calculator` inside
`Interface/AddOns`, copy `zul-reset-calculator.lua` and the matching platform TOC
file (`_Mainline`, `_Vanilla`, `_Mists`, or `_WoWForever`) into that directory,
and then start or reload the game client.

## Usage

Use `/zul` to list the next three resets. An optional count and chat channel
can be supplied in either order, for example `/zul 5 guild` or `/zul g 5`.
Supported channels are say, yell, party, raid, and guild.

## Development

The Makefile provides the following checks:

```sh
make syntax       # Parse Lua sources with luac
make lint         # Run luacheck
make shell-lint   # Run shellcheck and bashate
make test         # Run the Lua behavior tests
make diff-check   # Check the Git diff for whitespace errors
```

Development requires Lua and `luac`; install `luacheck` separately to run the
Lua lint target. Run `make venv` to create `.venv` and install `shellcheck-py`
and `bashate`, then run `make shell-lint`.
