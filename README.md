# zul-reset-calculator

An addon for World of Warcraft to calculate resets for 3-day reset raids like Zul'Gurub and Blackfathom Depths inside the game client.

## Installation

### Install script

Run the installation script with the game's `Interface/AddOns` directory:

```sh
./install.sh "/path/to/World of Warcraft/_retail_/Interface/AddOns"
```

Use the corresponding client directory for Classic Era (`_classic_era_`),
Mists Classic (`_classic_`), or WoW Forever Beta. The script installs the addon
Lua file and all supported TOC files into `zul-reset-calculator`.

### Manual installation

1. Create `zul-reset-calculator` inside the game's `Interface/AddOns` directory.
2. Copy `zul-reset-calculator.lua` and the matching platform TOC file
   (`_Mainline`, `_Vanilla`, `_Mists`, or `_WoWForever`) into that directory.
3. Start or reload the game client.

## Usage

Use `/zul` to list the next three resets. An optional count and chat channel
can be supplied in either order, for example `/zul 5 guild` or `/zul g 5`.
Supported channels are say, yell, party, raid, and guild.

## Development

The Makefile provides the following checks:

```sh
make syntax       # Parse Lua sources with luac
make lint         # Run luacheck
make test         # Run the Lua behavior tests
make diff-check   # Check the Git diff for whitespace errors
```

Development requires Lua and `luac`; install `luacheck` separately to run the
lint target.
